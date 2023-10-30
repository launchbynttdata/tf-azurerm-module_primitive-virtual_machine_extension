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

variable "name" {
  type        = string
  description = "(Required) The name of the virtual machine extension peering. Changing this forces a new resource to be created."
}

variable "virtual_machine_id" {
  type        = string
  description = "(Required) The ID of the Virtual Machine. Changing this forces a new resource to be created"
}

variable "publisher" {
  type        = string
  description = "(Required) The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created."
}

variable "type" {
  type        = string
  description = "(Required) The type of extension, available types for a publisher can be found using the Azure CLI."
}

variable "type_handler_version" {
  type        = string
  description = "(Required) Specifies the version of the extension to use, available versions can be found using the Azure CLI."
}

variable "auto_upgrade_minor_version" {
  type        = bool
  description = "(Optional) Specifies if the platform deploys the latest minor version update to the type_handler_version specified."
  default     = false
}

variable "automatic_upgrade_enabled" {
  type        = bool
  description = "(Optional) Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension?"
  default     = false
}

variable "settings" {
  type        = string
  description = "(Optional) The settings passed to the extension, these are specified as a JSON object in a string. Changing this forces a new resource to be created."
}

variable "failure_suppression_enabled" {
  type        = bool
  description = "(Optional) Should failures from the extension be suppressed? Possible values are true or false."
  default     = false
}

variable "protected_settings" {
  type        = string
  description = "(Optional) The protected_settings passed to the extension, like settings, these are specified as a JSON object in a string."
  default     = null
}

variable "protected_settings_from_key_vault" {
  type = object({
    secret_url      = string
    source_vault_id = string
  })
  description = "(Optional) Map of protected settings from Key Vault. Can not be used with protected_settings"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
