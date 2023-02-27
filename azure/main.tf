terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatep6cue"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

module "state_storage" {
  source = "./modules/state_storage"
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source              = "./modules/resource_group"
  location            = var.location
  resource_group_name = var.resource_group_name
  additional_tags     = var.additional_tags
}

module "virtual_network" {
  source               = "./modules/virtual_network"
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
  additional_tags      = var.additional_tags
}

module "subnet" {
  source               = "./modules/subnet"
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.virtual_network.vnet_id
  subnet_name          = var.subnet_name
  subnet_address       = var.subnet_address
  additional_tags      = var.additional_tags
}

# module "azure_firewall" {
#   source = "./modules/azure_firewall"
# }

# module "internal_central_hub" {
#   source = "./modules/internal_central_hub"
# }
