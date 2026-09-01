// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "random_password" "admin_password" {
  length           = var.length
  special          = true
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "!@#$%*"
}

module "virtual_machine_extension" {
  source = "../.."

  name                 = local.virtual_machine_extension_name
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = var.extension_publisher
  type                 = var.extension_type
  type_handler_version = var.extension_type_version
  settings             = var.extension_settings
}

# Published windows_virtual_machine still requires Terraform <= 1.5.5; create
# the VM inline so example CI can use the skeleton Terraform 1.10.x toolchain.
resource "azurerm_windows_virtual_machine" "this" {
  name                  = local.virtual_machine_name
  resource_group_name   = local.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = random_password.admin_password.result
  network_interface_ids = [module.network_interface.id]

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  lifecycle {
    ignore_changes = [admin_password]
  }

  depends_on = [module.resource_group]
}

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.2"

  name     = local.resource_group_name
  location = var.location
  tags = {
    resource_name = local.resource_group_name
  }
}

module "network_interface" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/network_interface/azurerm"
  version = "~> 1.0"

  name                = local.network_interface_name
  location            = var.location
  resource_group_name = local.resource_group_name

  ip_configuration = [{
    name                          = "internal"
    subnet_id                     = module.virtual_network.vnet_subnet_name_id_map["virtual_network"]["example_subnet"]
    private_ip_address_allocation = "Dynamic"
  }]
  depends_on = [module.resource_group, module.virtual_network]
}

module "virtual_network" {
  source  = "terraform.registry.launch.nttdata.com/module_collection/virtual_network/azurerm"
  version = "~> 1.2"

  network_map = local.modified_network_map
  depends_on  = [module.resource_group]
}

# This module generates the resource-name of resources based on resource_type, naming_prefix, env etc.
module "resource_names" {
  source   = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version  = "~> 2.0"
  for_each = var.resource_names_map

  region                  = join("", split("-", var.location))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}
