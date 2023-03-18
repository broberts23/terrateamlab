resource "azurerm_public_ip" "vmss_lb_pip" {
  name                = var.loadbalancerIpName
  location            = var.location
  resource_group_name = var.resourceGroupName
  allocation_method   = "Static"
  tags                = merge(var.additionalTags)
}

resource "azurerm_lb" "vmss_lb" {
  name                = var.loadbalancerName
  location            = var.location
  resource_group_name = var.resourceGroupName
  tags                = merge(var.additionalTags)

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.vmss_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "vmss_bepool" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "vmss_probe" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "website-probe"
  port            = var.httpPort
}

resource "azurerm_lb_rule" "vmss_lb_rule" {
  loadbalancer_id                = azurerm_lb.vmss_lb.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = var.httpPort
  backend_port                   = var.httpPort
  frontend_ip_configuration_name = "PublicIPAddress"
  //bacbackend_address_pool_ids    = azurerm_lb_backend_address_pool.vmss_bepool.id
  probe_id = azurerm_lb_probe.vmss_probe.id
}



