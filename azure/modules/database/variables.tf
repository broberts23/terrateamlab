variable "resourceGroupName" {}
variable "location" {}
variable "virtualNetworkName" {}
variable "additionalTags" {}
variable "cosmosdbAccount" {}
variable "cosmosdbName" {}
variable "cosmosdbofferType" {}
variable "cosmosdbkind" {}
variable "cosmosdbAutomaticFailover" {}
variable "geoLocationPrimary" {}
variable "geoLocationSeconday" {}
variable "consistencyPolicy" {}
variable "dynamodbBackup" {}
variable "enpointsubnet" {}
variable "dynamodbPrivateEndpointName" {}
variable "max_throughput" {
  type        = number
  default     = 4000
  description = "Cosmos db database max throughput"
  validation {
    condition     = var.max_throughput >= 4000 && var.max_throughput <= 1000000
    error_message = "Cosmos db autoscale max throughput should be equal to or greater than 4000 and less than or equal to 1000000."
  }
  validation {
    condition     = var.max_throughput % 100 == 0
    error_message = "Cosmos db max throughput should be in increments of 100."
  }
}