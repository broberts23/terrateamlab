resource "azurerm_cosmosdb_account" "mongodbaccount" {
  name                = var.cosmosdbAccount
  location            = var.location
  resource_group_name = var.resourceGroupName
  offer_type          = var.cosmosdbofferType
  kind                = var.cosmosdbkind
  enable_automatic_failover = var.cosmosdbAutomaticFailover
  tags                = merge(var.additionalTags)

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "EnableServerless"
  }

  mongo_server_version = var.mongodbVerion

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
