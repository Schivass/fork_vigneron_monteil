variable "subscription_id" { 
  type = string 
  description = "The Azure subscription ID if you want to diplay it use the command az -login" 
}

variable "github_username" { 
  type = string 
  description = "The github username"  
}

#resource group
variable "resource_group_name" { 
  type = string 
  description = "The name of the resource group" 
}

variable "location" { 
  type = string 
  default = "FranceCentral"
  description = "The location of the resource group" 
}


# Beginning App service module variable -------------------------------------------------------------------------------------------
# variable "enable_app_service" { 
#   type = bool 
#   description = "Enable the app service" 
# }

## Docker image app service
variable "docker_image" { 
  type = string 
  description = "The docker image" 
  default = "ghcr.io/Schivass/fork_vigneron_monteil:latest"
}

variable "docker_registry_username" { 
  type = string 
  description = "The docker registry username"
  default = "Schivass" 
}

variable "docker_registry_password" { 
  type = string 
  description = "The docker registry password" 
}

variable "docker_registry_url" { 
  type = string 
  description = "The docker registry url" 
  default = "https://ghcr.io"
}

## Database app service and use in database module
variable "administrateur_login" { 
  type = string 
  description = "The database admin username" 
  sensitive = true
}

## Database app service and use in database module
variable "administrateur_password" { 
  type = string 
  description = "The database admin password" 
  sensitive = true
}
# End App service module variable -------------------------------------------------------------------------------------------


# Beginning Database module variable -------------------------------------------------------------------------------------------

