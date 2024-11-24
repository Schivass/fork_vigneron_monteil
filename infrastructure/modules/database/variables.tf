# database variables

variable "administrateur_login" { 
  type = string 
  description = "The database admin username" 
}

variable "administrateur_password" { 
  type = string 
  description = "The database admin password" 
}

variable "location" { 
  type = string 
  default = "FranceCentral"
  description = "The location" 
}

variable "server_name" { 
  type = string 
  description = "The server name"  
}

variable "resource_group_name" { 
  type = string 
  description = "The resource group name" 
}

variable "database_name" { 
  type = string 
  description = "The postgresql name" 
}