# Output the storage account details for backend configuration
output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
  description = "Name of the storage account for Terraform state"
}

output "storage_account_resource_group" {
  value = azurerm_resource_group.tfstate.name
  description = "Resource group of the storage account"
}

output "storage_container_name" {
  value = azurerm_storage_container.tfstate.name
  description = "Name of the storage container for Terraform state"
}