resource "azurerm_app_service_environment_v3" "ase_01" {
  name                         = var.aseName
  resource_group_name          = var.resourceGroupName
  subnet_id                    = var.subnet
  internal_load_balancing_mode = "Web, Publishing"

  cluster_setting {
    name  = "DisableTls1.0"
    value = "1"
  }

  cluster_setting {
    name  = "InternalEncryption"
    value = "true"
  }

  cluster_setting {
    name  = "FrontEndSSLCipherSuiteOrder"
    value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
  }

  tags = merge(var.additionalTags)
}

resource "azurerm_service_plan" "asp_01" {
  name                       = var.aspName
  resource_group_name        = var.resourceGroupName
  location                   = var.location
  os_type                    = "Linux"
  sku_name                   = var.aspSku
  app_service_environment_id = azurerm_app_service_environment_v3.ase_01.id
}

resource "azurerm_linux_web_app" "web_app_01" {
  name                = var.webAppName
  resource_group_name = var.resourceGroupName
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp_01.id
  https_only          = true
  app_settings = {
    "WEBSITE_DNS_SERVER": "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL": "1"
  }
  site_config {
    minimum_tls_version = "1.2"
  }
}

resource "azurerm_linux_web_app_slot" "web_app_slot_blue" {
  name           = "example-slot-blue"
  app_service_id = azurerm_linux_web_app.web_app_01.id
  https_only     = true
  site_config {
    minimum_tls_version = "1.2"
  }
}

resource "azurerm_linux_web_app_slot" "web_app_slot_green" {
  name           = "example-slot-green"
  app_service_id = azurerm_linux_web_app.web_app_01.id
  https_only     = true
  site_config {
    minimum_tls_version = "1.2"
  }
}