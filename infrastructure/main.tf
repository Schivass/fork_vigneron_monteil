resource "azurerm_resource_group" "resource_group_cloud" {
  # Create a resource group
  name     = var.resource_group_name
  location = var.location  
}

# locals variables for readeability
locals {
  resource_group = azurerm_resource_group.resource_group_cloud.name
  location = azurerm_resource_group.resource_group_cloud.location
  app_name= "projet-terraform-${var.github_username}"
}
# First module is about app service
module "app_service" {
  source = "./modules/app_service"
  # count = var.enable_app_service ? 1 : 0

  resource_group_name = local.resource_group
  location = local.location
  app_name = local.app_name

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
}

# Second module is about database
module "database" {
  source = "./modules/database"
  # count = var.enable_database ? 1 : 0

  server_name = "server-${local.app_name}"
  resource_group_name = local.resource_group
  location = local.location
  database_name = "database-${local.app_name}"
  
  administrateur_login = var.administrateur_login
  administrateur_password = var.administrateur_password
}

module "quotes_storage" {
  source = "./modules/quotes_storage"
  # count = var.enable_storage ? 1 : 0

  resource_group_name = local.resource_group
  location = local.location
  storage_account_name = "qstorage132"
}

locals {
  storage_url = try(module.quotes_storage[0].url, null)
}