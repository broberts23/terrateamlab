data "azurerm_client_config" "current" {}

resource "tls_private_key" "vmss_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "azurerm_key_vault" "kv1" {
  name                        = var.kv_name
  resource_group_name         = var.kv_rg
}

resource "azurerm_key_vault_secret" "privatekey" {
  name         = "private-key"
  value        = tls_private_key.vmss_ssh_key.private_key_pem
  key_vault_id = data.azurerm_key_vault.kv1.id
}

