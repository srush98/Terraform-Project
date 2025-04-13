# File: modules/network/outputs.tf

# Output the name of the virtual network
output "virtual_network_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the virtual network."
}

# Output the name of the subnet
output "subnet_name" {
  value       = azurerm_subnet.subnet.name
  description = "The name of the subnet."
}

# Output the ID of the subnet
output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
