resource "azurerm_cosmosdb_account" "account" {
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

resource "azurerm_cosmosdb_sql_database" "main" {
  name                = var.cosmosdbName
  resource_group_name = azurerm_cosmosdb_account.account.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name
  autoscale_settings {
    max_throughput = var.cosmosdbThroughput
  }
}

resource "azurerm_cosmosdb_sql_container" "example" {
  name                  = var.cosmosdbName
  resource_group_name   = var.resourceGroupName
  account_name          = azurerm_cosmosdb_account.account.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  autoscale_settings {
    max_throughput = var.max_throughput
  }

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
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