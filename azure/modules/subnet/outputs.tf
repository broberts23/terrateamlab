output "vmssSubnet_id" {
  value = values(azurerm_subnet.subnet)[0].id
}

output "aseSubnet_id" {
  value = values(azurerm_subnet.subnet)[1].id
}