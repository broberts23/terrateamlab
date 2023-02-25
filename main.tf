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

# module "windows_virtual_network" {
#   source = "./modules/windows_virtual_network"
# }

# module "azure_firewall" {
#   source = "./modules/azure_firewall"
# }

# module "internal_central_hub" {
#   source = "./modules/internal_central_hub"
# }
