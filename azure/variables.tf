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
variable "resource_group_name" {}
variable "location" {}

// Vnet
variable "virtual_network_name" {}
variable "address_space" {}

// Subnet
variable "subnet_name" {}
variable "subnet_address" {}

// VMSS
variable "vmss_name" {}
variable "vmss_sku" {}
variable "vmss_instance_count" {}
variable "image" {}
variable "disk" {}
variable "public_key" {}

// Load Balancer
variable "loadbalanceripname" {}
variable "loadbalancername" {}
variable "http_port" {}

// Tags
variable "additional_tags" {}