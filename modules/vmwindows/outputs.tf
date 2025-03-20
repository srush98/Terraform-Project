# File: modules/vmwindows-9400/outputs.tf

# Output the hostname of the Windows VM
output "hostname" {
  value = [for vm in azurerm_windows_virtual_machine.win-vm : vm.name]
}

# Output the domain name of the Windows VM
output "domain_name" {
  value = [for pip in azurerm_public_ip.win-pip : pip.fqdn]
}

# Output the private IP address of the Windows VM
output "private_ip" {
  value = [for nic in azurerm_network_interface.win-nic : nic.private_ip_address]
}

# Output the public IP address of the Windows VM
output "public_ip" {
  value = [for pip in azurerm_public_ip.win-pip : pip.ip_address]
}

# Output the ID of the Windows VM
output "vm_id" {
  description = "Windows VM ID"
  value       = azurerm_windows_virtual_machine.win-vm[0].id
}
