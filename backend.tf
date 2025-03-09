terraform {
  required_version = ">= 1.0"

  backend "azurerm" {
    resource_group_name  = "tfstate-rg-9400"
    storage_account_name = "tfstateacc9400"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}