resource "azurerm_resource_group" "resource_group_cloud" {
  # Create a resource group
  name     = var.resource_group_name
  location = var.location  
}

resource "random_id" "server_name" {
  byte_length = 3
}

locals {
  resource_group = azurerm_resource_group.resource_group_cloud.name
  location = azurerm_resource_group.resource_group_cloud.location
  app_name= "projet-terraform-${var.github_username}"
  app_name_lowercase_and_numbers = lower(replace(local.app_name, "/[^a-z0-9]/", ""))
}

module "app_service" {
  source = "./modules/app_service"
  # We saw this on the previous repo and i think it's a good tùhing for code testing
  # count = var.enable_app_service ? 1 : 0

  resource_group_name = local.resource_group
  location = local.location
  app_name = local.app_name
  virtual_network_name = module.vnet.virtual_network_name
  network_security_group_id = module.vnet.network_security_group_id

  # docker image
  docker_image = var.docker_image
  docker_registry_username = var.docker_registry_username
  docker_registry_password = var.docker_registry_password
  docker_registry_url = var.docker_registry_url

  # database 
  database_name = module.database.postgresql_name
  database_username = var.administrateur_login
  database_password = var.administrateur_password
  database_host = module.database.postgresql_host
  database_port = module.database.postgresql_port

  # blob storage
  storage_url = module.quotes_storage.storage_url
  storage_account_id = module.quotes_storage.storage_account_id


  depends_on = [ module.vnet ]
}

module "database" {
  source = "./modules/database"
  # count = var.enable_database ? 1 : 0

  server_name = "${local.app_name}${random_id.server_name.hex}"     # Recognizable server name with rng to make it unique
  resource_group_name = local.resource_group
  location = local.location
  database_name = "database-${local.app_name}"
  virtual_network_name = module.vnet.virtual_network_name
  network_security_group_id = module.vnet.network_security_group_id
  
  administrateur_login = var.administrateur_login
  administrateur_password = var.administrateur_password
  depends_on = [ module.vnet ]
}

module "quotes_storage" {
  source = "./modules/quotes_storage"
  # count = var.enable_storage ? 1 : 0

  resource_group_name = local.resource_group
  location = local.location
  storage_account_name = local.app_name_lowercase_and_numbers
  virtual_network_name = module.vnet.virtual_network_name
  network_security_group_id = module.vnet.network_security_group_id

  depends_on = [ module.vnet ]
}

module "vnet" {
  source = "./modules/vnet"
  virtual_network_name = local.app_name
  # database_subnet_name = var.database_subnet_name
  # blob_subnet_name = var.blob_subnet_name
  # app_subnet_name = var.app_subnet_name
  location = local.location
  virtual_network_firewall_name = local.app_name
  resource_group_name = local.resource_group
  security_group_name = local.app_name
}

# Don't needed here because we don't use it but it's a good practice
locals {
  storage_url = try(module.quotes_storage[0].url, null)
}