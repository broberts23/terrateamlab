terraform {
  required_version = ">= 1.4.0"
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
  source            = "./modules/resource_group"
  location          = var.location
  resourceGroupName = var.resourceGroupName
  additionalTags    = var.additionalTags
}

module "virtual_network" {
  source             = "./modules/virtual_network"
  location           = var.location
  resourceGroupName  = var.resourceGroupName
  virtualNetworkName = var.virtualNetworkName
  addressSpace       = var.addressSpace
  additionalTags     = var.additionalTags
}

module "subnet" {
  source             = "./modules/subnet"
  location           = var.location
  resourceGroupName  = var.resourceGroupName
  virtualNetworkName = module.virtual_network.vnet_id
  subnetName         = var.subnetName
  subnetAddress      = var.subnetAddress
  additionalTags     = var.additionalTags
}

module "loadbalancer" {
  source             = "./modules/load_balancer"
  location           = var.location
  resourceGroupName  = var.resourceGroupName
  loadbalancerIpName = var.loadbalancerIpName
  loadbalancerName   = var.loadbalancerName
  httpPort           = var.httpPort
  additionalTags     = var.additionalTags
}

module "sshkey" {
  source               = "./modules/ssh_key"
  keyVaultName         = var.keyVaultName
  keyVaulResourceGroup = var.keyVaulResourceGroup
}

module "vmss" {
  source                  = "./modules/vmss"
  location                = var.location
  resourceGroupName       = var.resourceGroupName
  subnet_id               = module.subnet.subnet_id
  vmssName                = var.vmssName
  vmssInstanceCount       = var.vmssInstanceCount
  vmssSku                 = var.vmssSku
  additionalTags          = var.additionalTags
  image                   = var.image
  disk                    = var.disk
  public_key              = module.sshkey.vmss_ssh_key
  backend_address_pool_id = module.loadbalancer.backend_address_pool_id
  // Autocale variables
}

module "servicebus" {
  source                  = "./modules/service_bus"
  additionalTags          = var.additionalTags
  location                = var.location
  resourceGroupName       = var.resourceGroupName
  servicebusNamespaceName = var.servicebusNamespaceName
  servicebusNamespaceSku  = var.servicebusNamespaceSku
  serviceBusQueueName     = var.serviceBusQueueName
}
