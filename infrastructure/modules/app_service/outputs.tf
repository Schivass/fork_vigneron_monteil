output "principal_id" {
  value = azurerm_linux_web_app.app_service
  description = "Identity Management"
}

output "app_service_url" {
  value = "https://${azurerm_linux_web_app.app_service.default_hostname}"
  description = "The URL of the app service"
}