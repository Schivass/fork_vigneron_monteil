# variables for app service module

variable "app_name" { 
  type = string 
  description = "The name of the resource group" 
}

variable "location" { 
  type = string 
  description = "The location of the resource group" 
}

variable "resource_group_name" { 
  type = string 
  description = "The name of the resource group" 
}


# docker variables
variable "docker_image" { 
  type = string 
  description = "The docker image" 
}

variable "docker_registry_username" { 
  type = string 
  description = "The docker registry username" 
}

variable "docker_registry_password" { 
  type = string 
  description = "The docker registry password" 
}

variable "docker_registry_url" { 
  type = string 
  description = "The docker registry url" 
}

# database variables

variable "database_name" { 
  type = string 
  description = "The database name" 
}

variable "database_username" { 
  type = string 
  description = "The database username" 
}

variable "database_password" { 
  type = string 
  description = "The database password" 
}

variable "database_host" { 
  type = string 
  description = "The database host" 
}

variable "database_port" { 
  type = string 
  description = "The database port" 
}

# storage variables

variable "storage_url" { 
  type = string 
  description = "The storage url" 
}

variable "storage_account_id" { 
  type = string 
  description = "The storage account id" 
}

variable "virtual_network_name" {
  type = string
}

variable "network_security_group_id" {
  type = string
}