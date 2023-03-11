# Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnetName
  resource_group_name  = var.resourceGroupName
  virtual_network_name = var.virtualNetworkName
  address_prefixes     = [var.subnetAddress]
}
