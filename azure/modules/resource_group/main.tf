resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
  tags     = merge(var.additionalTags)
}
