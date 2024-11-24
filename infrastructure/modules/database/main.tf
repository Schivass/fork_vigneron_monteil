resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  administrator_login = var.administrateur_login
  administrator_password = var.administrateur_password

  auto_grow_enabled = false
  backup_retention_days = 7
  geo_redundant_backup_enabled = false

  location = var.location
  name = var.server_name
  resource_group_name = var.resource_group_name

  sku_name = "B_Standard_B1ms"
  storage_tier = "P4"
  storage_mb = 32768
  version = "11"
  zone = "1"
}

resource "azurerm_postgresql_flexible_server_database" "Schivas_database" {
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id
  name = var.database_name
}
