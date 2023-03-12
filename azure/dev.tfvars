// Core Vars
location          = "australiaeast"
resourceGroupName = "terrateam-dev-rg"

// Network
virtualNetworkName = "dev-vnet-01"
addressSpace       = "10.0.0.0/16"
subnetName         = "dev-subnet-01"
subnetAddress      = "10.0.1.0/24"

// VMSS
vmssName          = "dev-vmss-01"
vmssSku           = "Standard_F2"
vmssInstanceCount = "3"
image = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "22.04-LTS"
  version   = "latest"
}
disk = {
  storageAccountType = "Standard_LRS"
  caching            = "ReadWrite"
}

// Tags
additionalTags = {
  Name        = "TerrateamTesting"
  Environment = "Dev"
}

// Load Balancer
loadbalancerIpName = "dev-lbpip-01"
loadbalancerName   = "dev-lb-01"
httpPort           = "3000"

// SSH Key
keyVaultName               = "tf-core-backend-kv469"
keyVaulResourceGroup = "tfstate"

// Servicebus
servicebusNamespaceName = "dev-servicebus-01"
servicebusNamespaceSku  = "Standard"
serviceBusQueueName = [
    "inputQueue01",
    "inputQueue02",
    // The queue structure makes no sense. Just wanted to use regex to set a variable
    "outputQueue01",
    "outputQueue02"
  ]