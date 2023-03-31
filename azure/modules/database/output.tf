output "cosmos_db_endpoint" {
  value = azurerm_cosmosdb_account.mongodbaccount.endpoint
}

output "cosmos_db_masterkey" {
  value = azurerm_cosmosdb_account.mongodbaccount.primary_key
}