resource "azurerm_cosmosdb_account" "mongodbaccount" {
  name                      = var.cosmosdbAccount
  location                  = var.location
  resource_group_name       = var.resourceGroupName
  offer_type                = var.cosmosdbofferType
  kind                      = var.cosmosdbkind
  enable_automatic_failover = var.cosmosdbAutomaticFailover
  tags                      = merge(var.additionalTags)
  // Security Best Practice from checkov: https://docs.bridgecrew.io/
  public_network_access_enabled      = false
  access_key_metadata_writes_enabled = false
  mongo_server_version               = var.mongodbVerion

  //convert the capabilities to vars and setup for foreach block
  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level       = var.consistencyPolicy.consistencyLevel
    max_interval_in_seconds = var.consistencyPolicy.maxInterval
    max_staleness_prefix    = var.consistencyPolicy.masStaleness
  }

  geo_location {
    location          = var.geoLocationSeconday
    failover_priority = 1
  }

  geo_location {
    location          = var.geoLocationPrimary
    failover_priority = 0
  }

  backup {
    type                = var.dynamodbBackup.type
    interval_in_minutes = var.dynamodbBackup.interval
    retention_in_hours  = var.dynamodbBackup.retention
    storage_redundancy  = var.dynamodbBackup.redundancy
  }
}

resource "azurerm_cosmosdb_mongo_database" "mongodbdatabase" {
  name                = var.cosmosdbName
  resource_group_name = azurerm_cosmosdb_account.mongodbaccount.resource_group_name
  account_name        = azurerm_cosmosdb_account.mongodbaccount.name
  throughput          = var.cosmosdbThroughput
}

resource "azurerm_private_endpoint" "cosmos_endpoint" {
  name                = var.dynamodbPrivateEndpointName
  location            = var.location
  resource_group_name = var.resourceGroupName
  subnet_id           = var.enpointsubnet

  private_service_connection {
    name                           = "${azurerm_cosmosdb_account.mongodbaccount.name}-connection"
    private_connection_resource_id = azurerm_cosmosdb_account.mongodbaccount.id
    is_manual_connection           = false
  }
}