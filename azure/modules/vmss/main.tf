# Generate random text for a unique storage account name
resource "azurerm_linux_virtual_machine_scale_set" "vmss_01" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vmss_sku
  instances           = var.vmss_instance_count
  admin_username      = "adminuser"
  tags                = merge(var.additional_tags)

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
    storage_account_type = var.disk.storage_account_type
    caching              = var.disk.caching
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "startup_script" {
  name                         = "startup-script"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss_01.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({ 
    "fileUris" = ["https://tfstatep6cue.blob.core.windows.net/devscripts/startup.sh"],
    "commandToExecute" = "sh startup.sh"
    }
  )
}

