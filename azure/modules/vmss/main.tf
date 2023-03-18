
resource "azurerm_linux_virtual_machine_scale_set" "vmss_01" {
  name                = var.vmssName
  resource_group_name = var.resourceGroupName
  location            = var.location
  sku                 = var.vmssSku
  instances           = var.vmssInstanceCount
  admin_username      = "adminuser"
  tags                = merge(var.additionalTags)

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  os_disk {
    storage_account_type = var.disk.storageAccountType
    caching              = var.disk.caching
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_address_pool_id]
    }
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "vmss-extension" {
  name                         = "vmss-extension"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss_01.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "fileUris"         = ["https://tfstatep6cue.blob.core.windows.net/devscripts/startup.sh"],
    "commandToExecute" = "sh startup.sh"
    }
  )
}

resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = "myAutoscaleSetting"
  resource_group_name = var.resourceGroupName
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss_01.id

  profile {
    name = "defaultProfile"

    capacity {
      default = 3
      minimum = 3
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss_01.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss_01.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["admin@contoso.com"]
    }
  }
}
