output "cosmos_db_endpoint" {
  value = azurerm_cosmosdb_account.account.endpoint
}

output "cosmos_db_masterkey" {
  value = azurerm_cosmosdb_account.account.primary_key
}