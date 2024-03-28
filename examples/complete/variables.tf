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

//variables required by resource names module
variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
    virtual_machine = {
      name       = "vm"
      max_length = 15
    }
    virtual_network_vnet = {
      name       = "vnet"
      max_length = 80
    }
    network_interface = {
      name       = "iface"
      max_length = 80
    }
    extension = {
      name       = "ext"
      max_length = 80
    }
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "virtualmachine"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "location" {
  description = "target resource group resource mask"
  type        = string
}

// Virtual machine variables

variable "size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "A source_image_reference block."
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string, "CacheDisk")
    }))
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool, false)
  })
  description = "An os_disk block."
}

variable "admin_username" {
  description = "Username of the administrative account on the virtual machine"
  type        = string
}

// Admin password generation
variable "length" {
  type    = number
  default = 24
}

variable "number" {
  type    = bool
  default = true
}

variable "special" {
  type    = bool
  default = false
}

// Networking

variable "network_map" {
  description = "Map of spoke networks where vnet name is key, and value is object containing attributes to create a network"
  type = map(object({
    resource_group_name = optional(string)
    location            = optional(string)
    vnet_name           = optional(string)
    address_space       = list(string)
    subnet_names        = list(string)
    subnet_prefixes     = list(string)
    bgp_community       = string
    ddos_protection_plan = object(
      {
        enable = bool
        id     = string
      }
    )
    dns_servers                                           = list(string)
    nsg_ids                                               = map(string)
    route_tables_ids                                      = map(string)
    subnet_delegation                                     = map(map(any))
    subnet_enforce_private_link_endpoint_network_policies = map(bool)
    subnet_enforce_private_link_service_network_policies  = map(bool)
    subnet_service_endpoints                              = map(list(string))
    tags                                                  = map(string)
    tracing_tags_enabled                                  = bool
    tracing_tags_prefix                                   = string
    use_for_each                                          = bool
  }))
}

variable "extension_publisher" {
  description = "The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created. Defaults to 'Microsoft.Compute'"
  type        = string
  default     = "Microsoft.Compute"
}

variable "extension_type" {
  description = "The type of extension, available types for a publisher can be found using the Azure CLI. Defaults to 'CustomScriptExtension'"
  type        = string
  default     = "CustomScriptExtension"
}

variable "extension_type_version" {
  description = "Specifies the version of the extension to use, available versions can be found using the Azure CLI. Defaults to '1.10'"
  type        = string
  default     = "1.10"
}

variable "extension_settings" {
  description = "The settings passed to the extension, these are specified as a JSON object in a string."
  type        = string
}
