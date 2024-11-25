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
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
#   dns_servers       = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "projet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.projet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [ azurerm_virtual_network.projet ]
}

resource "azurerm_public_ip" "projet" {
  name                = "PubicIPaddr"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# resource "azurerm_firewall" "projet" {
#   name                = var.virtual_network_firewall_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku_name            = "AZFW_VNet"
#   sku_tier            = "Standard"

#   ip_configuration {
#     name                 = "firewall_configuration"
#     subnet_id            = var.su
#     public_ip_address_id = azurerm_public_ip.example.id
#   }
# }

# resource "azurerm_firewall_application_rule_collection" "projet" {
#   name                = "filterHTTP"
#   azure_firewall_name = azurerm_firewall.example.name
#   resource_group_name = var.resource_group_name
#   priority            = 100
#   action              = "Allow"

#   rule {
#     name = "testrule"

#     source_addresses = [
#       "10.0.0.0/16",
#     ]

#     target_fqdns = [
#       "*.google.com",
#     ]

#     protocol {
#       port = "443"
#       type = "Https"
#     }
#   }
# }