# We don't have use all the example but it can be see in full on (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)


resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  administrator_login           = var.administrateur_login
  administrator_password        = var.administrateur_password
  auto_grow_enabled             = false
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  location                      = var.location
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  sku_name                      = "B_Standard_B1ms"
  storage_tier                  = "P4"
  storage_mb                    = 32768
  version                       = "11"
  zone                          = "1"
  public_network_access_enabled = false
}

resource "azurerm_postgresql_flexible_server_database" "Schivas_database" {
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id
  name      = var.database_name
}


resource "azurerm_subnet" "database" {
  name                 = "database_sn"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
  # depends_on           = [ azurerm_virtual_network.projet ]
  delegation {
    name = "flexible_db_server"
    service_delegation {
      name    = "Microsoft.Web/hostingEnvironments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Link into subnet
resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = var.network_security_group_id
}