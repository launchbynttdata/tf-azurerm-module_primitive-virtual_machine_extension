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

resource "random_string" "admin_password" {
  length  = var.length
  numeric = var.number
  special = var.special
}

module "virtual_machine_extension" {
  source = "../.."

  name                 = local.virtual_machine_extension_name
  virtual_machine_id   = module.virtual_machine.id
  publisher            = var.extension_publisher
  type                 = var.extension_type
  type_handler_version = var.extension_type_version
  settings             = var.extension_settings
}

module "virtual_machine" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-windows_virtual_machine.git?ref=1.0.0"

  name                = local.virtual_machine_name
  resource_group_name = local.resource_group_name
  location            = var.location
  size                = var.size

  admin_username = var.admin_username
  admin_password = random_string.admin_password.result

  os_disk                = var.os_disk
  source_image_reference = var.source_image_reference
  network_interface_ids  = [module.network_interface.id]

  depends_on = [module.resource_group]
}

module "resource_group" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-resource_group.git?ref=1.0.0"

  name     = local.resource_group_name
  location = var.location
  tags = {
    resource_name = local.resource_group_name
  }
}

module "network_interface" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-network_interface.git?ref=1.0.0"

  name                = local.network_interface_name
  location            = var.location
  resource_group_name = local.resource_group_name

  ip_configuration = [{
    name                          = "internal"
    subnet_id                     = module.virtual_network.vnet_subnets["virtual_network"][0]
    private_ip_address_allocation = "Dynamic"
  }]
  depends_on = [module.resource_group, module.virtual_network]
}

module "virtual_network" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_collection-virtual_network.git?ref=1.0.0"

  network_map = local.modified_network_map
  depends_on  = [module.resource_group]
}

# This module generates the resource-name of resources based on resource_type, naming_prefix, env etc.
module "resource_names" {
  source   = "git::https://github.com/launchbynttdata/tf-launch-module_library-resource_name.git?ref=1.0.0"
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
