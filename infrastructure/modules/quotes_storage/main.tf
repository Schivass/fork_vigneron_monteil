resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "qcontainer"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage_blob" {
  name                   = "quotes.json"
  source                 = "${path.module}/quotes.json"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
}

resource "azurerm_subnet" "blob_storage" {
  name                 = "blob_storage_sn"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.3.0/24"]

  delegation {
    name = "blob_storage_server"
    service_delegation {
      name    = "Microsoft.Web/hostingEnvironments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Link into subnet
resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = azurerm_subnet.blob_storage.id
  network_security_group_id = var.network_security_group_id
}