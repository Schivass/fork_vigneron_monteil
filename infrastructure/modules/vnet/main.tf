resource "azurerm_network_security_group" "projet" {
  name                = var.security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "default"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "projet" {
  name                = "${var.resource_group_name}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
#   dns_servers       = ["10.0.0.4", "10.0.0.5"]
}


resource "azurerm_public_ip" "projet" {
  name                = "PubicIPaddr"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}