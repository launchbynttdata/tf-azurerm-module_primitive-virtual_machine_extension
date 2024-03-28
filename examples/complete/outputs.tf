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

output "vm_id" {
  description = "ID of the Virtual Machine"
  value       = module.virtual_machine.id
}

output "extension_id" {
  description = "ID of the extension"
  value       = module.virtual_machine_extension.id
}

output "extension_name" {
  description = "Name of the extension"
  value       = local.virtual_machine_extension_name
}

output "name" {
  description = "Name of the Virtual Machine"
  value       = local.virtual_machine_name
}

output "private_ip_addresses" {
  description = "Private IP Addresses"
  value       = module.virtual_machine.private_ip_addresses
}

output "public_ip_addresses" {
  description = "Public IP Addresses"
  value       = module.virtual_machine.public_ip_addresses
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = local.resource_group_name
}

output "admin_username" {
  description = "Login of the administrative user"
  value       = var.admin_username
}

output "admin_password" {
  description = "Password of the administrative user"
  value       = random_string.admin_password.result
  sensitive   = true
}
