class_env = "demo"
location  = "eastus2"
size      = "Standard_B1s"

admin_username = "terratest"

os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
}

source_image_reference = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-Datacenter"
  version   = "latest"
}

network_map = {
  virtual_network = {
    address_space                                         = ["192.0.0.0/16"]
    subnet_names                                          = ["example_subnet"]
    subnet_prefixes                                       = ["192.0.0.0/24"]
    bgp_community                                         = null
    ddos_protection_plan                                  = null
    dns_servers                                           = []
    nsg_ids                                               = {}
    route_tables_ids                                      = {}
    subnet_delegation                                     = {}
    subnet_enforce_private_link_endpoint_network_policies = {}
    subnet_enforce_private_link_service_network_policies  = {}
    subnet_service_endpoints                              = {}
    tags                                                  = {}
    tracing_tags_enabled                                  = false
    tracing_tags_prefix                                   = ""
    use_for_each                                          = true
  }
}

extension_settings = "{\"commandToExecute\": \"echo Hello Terratest\"}"
