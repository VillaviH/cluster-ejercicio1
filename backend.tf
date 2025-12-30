terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate${random_id.storage_account.hex}"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Generate random ID for storage account name
resource "random_id" "storage_account" {
  byte_length = 4
}