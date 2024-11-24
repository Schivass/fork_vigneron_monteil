output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
  description = "value of the storage account name"
}

output "storage_url" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
  description = "url of the storage"
}

output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
  description = "id of the storage account"
  
}