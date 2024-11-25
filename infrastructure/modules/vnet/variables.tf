variable "virtual_network_name" {
 type = string
 description = "The name of the virtual network" 
}

variable "virtual_network_firewall_name" {
  type = string
  description = "The name of the virtual network firewall"
}
variable "resource_group_name" {
  type = string 
  description = "The name of the resource group"
}

variable "location" {
    type = string
    description = "The geographical hosting location"
}

variable "security_group_name" {
  type = string
}
