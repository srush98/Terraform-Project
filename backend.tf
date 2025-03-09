# File: main module's backend.tf

# Backend configuration for the main module. It defines the state file and the storage account to store the state file.
terraform {
  required_version = ">= 1.0"

  backend "azurerm" {
    resource_group_name  = "tfstate-rg-9400"
    storage_account_name = "tfstateaccount9400"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
