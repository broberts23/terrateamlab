// Core Vars
location             = "australiaeast"
resource_group_name  = "terrateam-dev-rg"

// Network
virtual_network_name = "dev-vnet-01"
address_space        = "10.0.0.0/16"
subnet_name          = "dev-subnet-01"
subnet_address       = "10.0.1.0/24"

// VMSS
vmss_name           = "dev-vmss-01"
vmss_sku            = "Standard_F2"
vmss_instance_count = "3"
image = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "22.04-LTS"
  version   = "latest"
}
disk = {
  storage_account_type = "Standard_LRS"
  caching              = "ReadWrite"
}

// Tags
additional_tags = {
  Name        = "TerrateamTesting"
  Environment = "Dev"
}

// Load Balancer
loadbalanceripname = "dev-lbpip-01"
loadbalancername = "dev-lb-01"
http_port = "3000"

// SSH Key
kv_name = "tf-core-backend-kv469"
kv_rg = "tfstate"