output "servicebus_queue_id" {
  value = values(azurerm_servicebus_queue.service_bus_queue)[*].id
}
