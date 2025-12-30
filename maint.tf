# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Generate random suffix for storage account
resource "random_string" "storage_suffix" {
  length  = 6
  special = false
  upper   = false
}

# Resource group for Terraform state
resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-rg"
  location = "eastus2"
}

# Storage account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    purpose = "terraform-state"
  }
}

# Storage container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# Main infrastructure resources
resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "eastus2"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "myTFVnet"
  address_space       = ["172.50.0.0/24"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.rg.name
}