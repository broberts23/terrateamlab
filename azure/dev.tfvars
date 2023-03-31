// Core Vars
location          = "australiaeast"
resourceGroupName = "terrateam-dev-rg"

// Network
virtualNetworkName = "dev-vnet-01"
addressSpace       = "10.0.0.0/16"
subnets = {
  vmss = {
    subnetName    = "dev-vmsssubnet-01"
    subnetAddress = "10.0.1.0/24"
  }
  ase = {
    subnetName    = "dev-asesubnet-01"
    subnetAddress = "10.0.2.0/24"
  }
  endpoint = {
    subnetName    = "dev-endpoint-01"
    subnetAddress = "10.0.3.0/24"
  }
}

// VMSS Flex
vmssName          = "dev-vmss-01"
vmssSku           = "Standard_F2"
vmssInstanceCount = "3"
priorityMix       = 40
faultDomainCount  = 1
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
keyVaultName         = "tf-core-backend-kv469"
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

// DynamoDB
cosmosdbAccount           = "tfex-cosmosdb-account"
cosmosdbName              = "dev-cosmos-mongo-db"
cosmosdbofferType         = "Standard"
cosmosdbkind              = "MongoDB"
cosmosdbAutomaticFailover = true
cosmosdbThroughput        = 400
mongodbVerion             = 4.2
geoLocationPrimary        = "australiaeast"
geoLocationSeconday       = "australiasoutheast"
consistencyPolicy = {
  consistencyLevel = "BoundedStaleness"
  maxInterval      = 300
  masStaleness     = 100000
}
dynamodbBackup = {
  type       = "Continuous"
  interval   = 60
  retention  = 24
  redundancy = "Zone"
}

// Web Apps
aseName    = "dev-ase-01"
aspName    = "dev-asp-01"
aspSku     = "I2v2"
webAppName = "dev-webapp-01"
