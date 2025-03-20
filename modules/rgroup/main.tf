# File: modules/rgroup-n01669400/main.tf

# Define the Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
