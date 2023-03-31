terraform {
  required_version = ">= 1.3.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50.0"
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
  features {
    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }

    app_configuration {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }

    application_insights {
      disable_generated_rule = false
    }

    cognitive_account {
      purge_soft_delete_on_destroy = true
    }

    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }

    managed_disk {
      expand_without_downtime = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = true
    }

    template_deployment {
      delete_nested_items_during_deletion = true
    }

    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = false
    }

    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = true
    }
  }
}

module "state_storage" {
  source         = "./modules/state_storage"
  additionalTags = var.additionalTags
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
  priorityMix             = var.priorityMix
  faultDomainCount        = var.faultDomainCount
  backend_address_pool_id = module.loadbalancer.backend_address_pool_id
  cosmosdbMasterkey       = module.mongodb.cosmos_db_masterkey
  cosmosdbEndpoint        = module.mongodb.cosmos_db_endpoint
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

module "mongodb" {
  source                    = "./modules/database"
  additionalTags            = var.additionalTags
  location                  = var.location
  resourceGroupName         = var.resourceGroupName
  cosmosdbAccount           = var.cosmosdbAccount
  cosmosdbName              = var.cosmosdbName
  cosmosdbofferType         = var.cosmosdbofferType
  cosmosdbkind              = var.cosmosdbkind
  cosmosdbAutomaticFailover = var.cosmosdbAutomaticFailover
  cosmosdbThroughput        = var.cosmosdbThroughput
  mongodbVerion             = var.mongodbVerion
  geoLocationPrimary        = var.geoLocationPrimary
  geoLocationSeconday       = var.geoLocationSeconday
  consistencyPolicy         = var.consistencyPolicy
  dynamodbBackup            = var.dynamodbBackup
}
