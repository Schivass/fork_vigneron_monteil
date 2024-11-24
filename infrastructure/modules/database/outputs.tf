output "database_admin_username" {
  value = azurerm_postgresql_flexible_server.postgresql_server.administrator_login
  sensitive = true
}

output "database_admin_password" {
  value =  azurerm_postgresql_flexible_server.postgresql_server.administrator_password
  sensitive = true
}

output "postgresql_name" {
  value = azurerm_postgresql_flexible_server_database.Schivas_database.name
}

output "postgresql_host" {
  value = azurerm_postgresql_flexible_server.postgresql_server.fqdn
}

output "postgresql_port" {
  value = 5432
}