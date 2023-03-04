terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.45.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatep6cue"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "state_storage" {
  source = "./modules/state_storage"
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

module "loadbalancer" {
  source              = "./modules/load_balancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  loadbalanceripname  = var.loadbalanceripname
  loadbalancername    = var.loadbalancername
  http_port           = var.http_port
  additional_tags      = var.additional_tags
}


module "vmss" {
  source              = "./modules/vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.subnet_id
  vmss_name           = var.vmss_name
  vmss_instance_count = var.vmss_instance_count
  vmss_sku            = var.vmss_sku
  additional_tags     = var.additional_tags
  image               = var.image
  disk                = var.disk
  // Will prompt for key - Update with KV or Pipleline secret
  public_key              = var.public_key
  backend_address_pool_id = module.loadbalancer.backend_address_pool_id
}

// To Do
// NSG
// Key Vault
