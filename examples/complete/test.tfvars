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
  "virtual_network" = {
    address_space = ["192.0.0.0/16"]
    subnets = {
      example_subnet = {
        prefix = "192.0.0.0/24"
      }
    }
    bgp_community        = null
    ddos_protection_plan = null
    dns_servers          = []
    tags                 = {}
  }
}

extension_settings = "{\"commandToExecute\": \"echo Hello Terratest\"}"
