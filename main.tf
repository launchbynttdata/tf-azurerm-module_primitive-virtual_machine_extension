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

resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  name                        = var.name
  virtual_machine_id          = var.virtual_machine_id
  publisher                   = var.publisher
  type                        = var.type
  type_handler_version        = var.type_handler_version
  auto_upgrade_minor_version  = var.auto_upgrade_minor_version
  automatic_upgrade_enabled   = var.automatic_upgrade_enabled
  failure_suppression_enabled = var.failure_suppression_enabled
  protected_settings          = var.protected_settings

  dynamic "protected_settings_from_key_vault" {
    for_each = var.protected_settings_from_key_vault != null ? var.protected_settings_from_key_vault : {}
    content {
      secret_url      = each.secret_url
      source_vault_id = each.source_vault_id
    }
  }

  settings = var.settings
  tags     = var.tags
}
