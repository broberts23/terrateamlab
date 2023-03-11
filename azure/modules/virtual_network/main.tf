# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtualNetworkName
  address_space       = [var.addressSpace]
  location            = var.location
  resource_group_name = var.resourceGroupName
  tags                = merge(var.additionalTags)
}
