variable "resource_group" {
  default = ""
}

variable "azurerm_virtual_network" {
  default = ""
}

variable "location" {
  default = ""
}

locals {
  common_tags = {
    Name        = ""
    Environment = ""
  }
}