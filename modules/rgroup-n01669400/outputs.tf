# File: modules/rgroup/outputs.tf

# Output the name of the resource group
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the created resource group."
}
