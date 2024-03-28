locals {
  resource_group_name            = module.resource_names["resource_group"].standard
  virtual_machine_name           = "testvm"
  virtual_machine_extension_name = module.resource_names["extension"].standard
  network_interface_name         = module.resource_names["network_interface"].standard

  override_network_attributes_map = { for vnet_name, vnet in var.network_map : vnet_name => {
    resource_group_name = local.resource_group_name
    vnet_name           = module.resource_names["${vnet_name}_vnet"].standard
    location            = var.location
    }
  }

  modified_network_map = {
    for vnet_name, vnet in var.network_map : vnet_name => merge(vnet, local.override_network_attributes_map[vnet_name])
  }
}
