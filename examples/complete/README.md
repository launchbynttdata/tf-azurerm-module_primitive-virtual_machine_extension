# complete

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network_interface"></a> [network\_interface](#module\_network\_interface) | terraform.registry.launch.nttdata.com/module_primitive/network_interface/azurerm | ~> 1.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.2 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_virtual_machine"></a> [virtual\_machine](#module\_virtual\_machine) | git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-windows_virtual_machine.git | feat%21/copier-conversion |
| <a name="module_virtual_machine_extension"></a> [virtual\_machine\_extension](#module\_virtual\_machine\_extension) | ../.. | n/a |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | terraform.registry.launch.nttdata.com/module_collection/virtual_network/azurerm | ~> 1.2 |

## Resources

| Name | Type |
|------|------|
| [random_string.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Username of the administrative account on the virtual machine | `string` | n/a | yes |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_extension_publisher"></a> [extension\_publisher](#input\_extension\_publisher) | The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created. Defaults to 'Microsoft.Compute' | `string` | `"Microsoft.Compute"` | no |
| <a name="input_extension_settings"></a> [extension\_settings](#input\_extension\_settings) | The settings passed to the extension, these are specified as a JSON object in a string. | `string` | n/a | yes |
| <a name="input_extension_type"></a> [extension\_type](#input\_extension\_type) | The type of extension, available types for a publisher can be found using the Azure CLI. Defaults to 'CustomScriptExtension' | `string` | `"CustomScriptExtension"` | no |
| <a name="input_extension_type_version"></a> [extension\_type\_version](#input\_extension\_type\_version) | Specifies the version of the extension to use, available versions can be found using the Azure CLI. Defaults to '1.10' | `string` | `"1.10"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_length"></a> [length](#input\_length) | Admin password generation | `number` | `24` | no |
| <a name="input_location"></a> [location](#input\_location) | target resource group resource mask | `string` | n/a | yes |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br/>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br/>    For example, backend, frontend, middleware etc. | `string` | `"virtualmachine"` | no |
| <a name="input_network_map"></a> [network\_map](#input\_network\_map) | Map of spoke networks where vnet name is key, and value is object containing attributes to create a network | <pre>map(object({<br/>    resource_group_name = optional(string)<br/>    location            = optional(string)<br/>    vnet_name           = optional(string)<br/>    address_space       = list(string)<br/>    subnets = map(object({<br/>      prefix = string<br/>      delegation = optional(map(object({<br/>        service_name    = string<br/>        service_actions = list(string)<br/>      })), {})<br/>      service_endpoints                             = optional(list(string), []),<br/>      private_endpoint_network_policies_enabled     = optional(bool, false)<br/>      private_link_service_network_policies_enabled = optional(bool, false)<br/>      network_security_group_id                     = optional(string, null)<br/>      route_table_id                                = optional(string, null)<br/>    }))<br/>    bgp_community = optional(string, null)<br/>    ddos_protection_plan = optional(object(<br/>      {<br/>        enable = bool<br/>        id     = string<br/>      }<br/>    ), null)<br/>    dns_servers      = optional(list(string), [])<br/>    nsg_ids          = optional(map(string), {})<br/>    route_tables_ids = optional(map(string), {})<br/>    tags             = optional(map(string), {})<br/>  }))</pre> | n/a | yes |
| <a name="input_number"></a> [number](#input\_number) | n/a | `bool` | `true` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | An os\_disk block. | <pre>object({<br/>    caching              = string<br/>    storage_account_type = string<br/>    diff_disk_settings = optional(object({<br/>      option    = string<br/>      placement = optional(string, "CacheDisk")<br/>    }))<br/>    disk_encryption_set_id           = optional(string)<br/>    disk_size_gb                     = optional(number)<br/>    name                             = optional(string)<br/>    secure_vm_disk_encryption_set_id = optional(string)<br/>    security_encryption_type         = optional(string)<br/>    write_accelerator_enabled        = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>  }))</pre> | <pre>{<br/>  "extension": {<br/>    "max_length": 80,<br/>    "name": "ext"<br/>  },<br/>  "network_interface": {<br/>    "max_length": 80,<br/>    "name": "iface"<br/>  },<br/>  "resource_group": {<br/>    "max_length": 80,<br/>    "name": "rg"<br/>  },<br/>  "virtual_machine": {<br/>    "max_length": 15,<br/>    "name": "vm"<br/>  },<br/>  "virtual_network_vnet": {<br/>    "max_length": 80,<br/>    "name": "vnet"<br/>  }<br/>}</pre> | no |
| <a name="input_size"></a> [size](#input\_size) | (Required) The SKU which should be used for this Virtual Machine, such as Standard\_F2. | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | A source\_image\_reference block. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | n/a | yes |
| <a name="input_special"></a> [special](#input\_special) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Password of the administrative user |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Login of the administrative user |
| <a name="output_extension_id"></a> [extension\_id](#output\_extension\_id) | ID of the extension |
| <a name="output_extension_name"></a> [extension\_name](#output\_extension\_name) | Name of the extension |
| <a name="output_name"></a> [name](#output\_name) | Name of the Virtual Machine |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | Private IP Addresses |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | Public IP Addresses |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the resource group |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | ID of the Virtual Machine |
<!-- END_TF_DOCS -->
