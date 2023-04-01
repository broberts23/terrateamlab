
// Resource Group
variable "resourceGroupName" {}
variable "location" {}

// Vnet
variable "virtualNetworkName" {}
variable "addressSpace" {}

// Subnet
variable "subnets" {}
variable "delegationSubnets" {}

// VMSS Flex
variable "vmssName" {}
variable "vmssSku" {}
variable "vmssInstanceCount" {}
variable "image" {}
variable "disk" {}
variable "priorityMix" {}
variable "faultDomainCount" {}

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
variable "sbPrivateEndpointName" {}

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
variable "dynamodbPrivateEndpointName" {}

// Web App
variable "aseName" {}
variable "aspName" {}
variable "aspSku" {}
variable "webAppName" {}

// Tags
variable "additionalTags" {}
