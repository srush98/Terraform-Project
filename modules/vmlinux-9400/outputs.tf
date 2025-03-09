# File: modules/vmlinux-9400/outputs.tf

# Output the hostname of the Linux VM
output "linux_vm_hostnames" {
  description = "Hostnames of the Linux virtual machines"
  value       = [for vm in azurerm_linux_virtual_machine.linux-vm : vm.name]
}

# Output the domain name of the Linux VM
output "linux_vm_domain_names" {
  description = "Domain names of the Linux virtual machines"
  value       = [for pip in values(azurerm_public_ip.linux-pip) : pip.fqdn]
}

# Output the private IP address of the Linux VM
output "linux_vm_private_ips" {
  description = "Private IP addresses of the Linux virtual machines"
  value       = [for nic in values(azurerm_network_interface.linux-nic) : nic.private_ip_address]
}

# Output the public IP address of the Linux VM
output "linux_vm_public_ips" {
  description = "Public IP addresses of the Linux virtual machines"
  value       = [for pip in values(azurerm_public_ip.linux-pip) : pip.ip_address]
}

# Output the ID of the Linux VM
output "vm_ids" {
  description = "List of Linux VM IDs"
  value       = [for vm in azurerm_linux_virtual_machine.linux-vm : vm.id]
}

# Output the ID of the Linux VM NIC
output "linux_nic_ids" {
  description = "List of Linux VM NIC IDs"
  value       = [for nic in azurerm_network_interface.linux-nic : nic.id]
}
