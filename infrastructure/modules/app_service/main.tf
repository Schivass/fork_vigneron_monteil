# More info about this configuration can be found on (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)


resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.app_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app_service" {
  name = "${var.app_name}-server"
  location = azurerm_service_plan.app_service_plan.location
  resource_group_name = var.resource_group_name
  service_plan_id = azurerm_service_plan.app_service_plan.id

  # That's the part which make a self identity for our app service 
  # More info (https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure-with-managed-identity-for-azure-services)
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name = var.docker_image
      docker_registry_url = var.docker_registry_url
      docker_registry_username = var.docker_registry_username
      docker_registry_password = var.docker_registry_password
    }
  }

  app_settings =  {
    DATABASE_NAME = var.database_name
    DATABASE_USERNAME = var.database_username
    DATABASE_PASSWORD = var.database_password
    DATABASE_HOST = var.database_host
    DATABASE_PORT = var.database_port

    STORAGE_URL = var.storage_url
  }

}

resource "azurerm_role_assignment" "app_service_identity" {
  principal_id         = azurerm_linux_web_app.app_service.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope = var.storage_account_id
}


resource "azurerm_subnet" "app_service" {
  name                 = "app_service_sn"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
  # depends_on           = [ azurerm_virtual_network.projet ]
  delegation {
    name = "webapp_server"
    service_delegation {
      name    = "Microsoft.Web/hostingEnvironments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Link into subnet
resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = azurerm_subnet.app_service.id
  network_security_group_id = var.network_security_group_id
}