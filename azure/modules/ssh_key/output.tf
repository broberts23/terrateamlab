output "vmss_ssh_key" {
  value = azurerm_key_vault_secret.privatekey.value
}
