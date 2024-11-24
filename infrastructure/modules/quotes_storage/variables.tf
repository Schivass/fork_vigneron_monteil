variable "resource_group_name" {
  description = "The name of the resource group in which the database will be created."
  type        = string
}

variable "location" {
  description = "The location of the resource group in which the database will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}