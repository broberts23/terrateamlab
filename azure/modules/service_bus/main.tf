resource "azurerm_servicebus_namespace" "service_bus" {
  name                = var.servicebusNamespaceName
  location            = var.location
  resource_group_name = var.resourceGroupName
  sku                 = var.servicebusNamespaceSku
  tags                = merge(var.additionalTags)
}

resource "azurerm_servicebus_queue" "service_bus_queue" {
  for_each                             = toset(var.serviceBusQueueName)
  name                                 = each.value
  namespace_id                         = azurerm_servicebus_namespace.service_bus.id
  enable_partitioning                  = true
  dead_lettering_on_message_expiration = true
  forward_dead_lettered_messages_to    = "${each.value}-dlq"
}

resource "azurerm_servicebus_queue_authorization_rule" "service_bus_auth_rule" {
  for_each = toset(var.serviceBusQueueName)
  name     = "${each.value}-authRule"
  queue_id = azurerm_servicebus_queue.service_bus_queue[each.key].id
  listen   = startswith(each.value, "input")
  send     = startswith(each.value, "output")
  manage   = false
  depends_on = [
    azurerm_servicebus_queue.service_bus_queue
  ]
}
