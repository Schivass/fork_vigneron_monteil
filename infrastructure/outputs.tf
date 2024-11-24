# Just an example of how to output a resource group name
output "name_of_resource_group" {
  value = azurerm_resource_group.resource_group_cloud.name 
}

output "app_service_url" {
  value = "https://${azurerm_linux_web_app.app_service.default_hostname}"
  description = "The URL of the app service"
}