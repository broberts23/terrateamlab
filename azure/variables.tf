# variable "ARM_SUBSCRIPTION_ID" {
#   type    = string
#   default = ""
# }

# variable "ARM_CLIENT_SECRET" {
#   type    = string
#   default = ""
# }

# variable "ARM_CLIENT_ID" {
#   type    = string
#   default = ""
# }

// Resource Group
variable "resourceGroupName" {}
variable "location" {}

// Vnet
variable "virtualNetworkName" {}
variable "addressSpace" {}

// Subnet
variable "subnetName" {}
variable "subnetAddress" {}

// VMSS
variable "vmssName" {}
variable "vmssSku" {}
variable "vmssInstanceCount" {}
variable "image" {}
variable "disk" {}

// Load Balancer
variable "loadbalancerIpName" {}
variable "loadbalancerName" {}
variable "httpPort" {}

// SSH Key
variable "keyVaultName" {}
variable "keyVaulResourceGroup" {}

//Service Bus
variable "servicebusNamespaceName" {}
variable "servicebusNamespaceSku" {}
variable "serviceBusQueueName" {}

//DynamoDB
variable "cosmosdbAccount" {}
variable "cosmosdbName" {}
variable "cosmosdbofferType" {}
variable "cosmosdbkind" {}
variable "cosmosdbAutomaticFailover" {}
variable "cosmosdbThroughput" {}
variable "mongodbVerion" {}
variable "geoLocationPrimary" {}
variable "geoLocationSeconday" {}
variable "consistencyPolicy" {}
variable "dynamodbBackup" {}

// Tags
variable "additionalTags" {}
