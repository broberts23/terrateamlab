# Create a subnet
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value.subnetName
  resource_group_name  = var.resourceGroupName
  virtual_network_name = var.virtualNetworkName
  address_prefixes     = [each.value.subnetAddress]
}

resource "azurerm_subnet" "delegationSubnet" {
  for_each             = var.delegationSubnets
  name                 = each.value.subnetName
  resource_group_name  = var.resourceGroupName
  virtual_network_name = var.virtualNetworkName
  address_prefixes     = [each.value.subnetAddress]
  delegation {
    name = var.delegationName
    service_delegation {
      name    = var.serviceDelegationName
      actions = var.serviceDelegationName
    }
  }
}

