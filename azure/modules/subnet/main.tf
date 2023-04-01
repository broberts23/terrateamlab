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
    name = each.value.delegationName
    service_delegation {
      name    = each.value.serviceDelegationName
      actions = each.value.serviceDelegationActions
    }
  }
}

