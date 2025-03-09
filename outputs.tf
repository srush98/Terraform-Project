# File: main module's outputs.tf

# Output the name of the resource group
output "Resource-Group" {
  value = module.rgroup-n01669400.resource_group_name
}

# Output the name of the virtual network
output "Virtual-Network" {
  value = module.network-n01669400.virtual_network_name
}

# Output the name of the subnet
output "Subnet" {
  value = module.network-n01669400.subnet_name
}

# Output the name of the log analytics workspace
output "Log_analytics_workspace" {
  value = module.common-n01669400.log_analytics_workspace_name
}

# Output the name of the recovery services vault
output "Recovery_services_vault" {
  value = module.common-n01669400.recovery_services_vault_name
}

# Output the name of the storage account
output "Storage_Account" {
  value = module.common-n01669400.storage_account_name
}

# Output the information of the Linux VM
output "Linux_VM_info" {
  description = "Linux VM information"
  value = {
    hostnames    = module.vmlinux-n01669400.linux_vm_hostnames
    domain_names = module.vmlinux-n01669400.linux_vm_domain_names
    private_ips  = module.vmlinux-n01669400.linux_vm_private_ips
    public_ips   = module.vmlinux-n01669400.linux_vm_public_ips
  }
}

# Output the information of the Windows VM
output "Windows_VM_info" {
  description = "Windows VM information"
  value = {
    hostname    = module.vmwindows-n01669400.hostname
    domain_name = module.vmwindows-n01669400.domain_name
    private_ip  = module.vmwindows-n01669400.private_ip
    public_ip   = module.vmwindows-n01669400.public_ip
  }
}

output "Linux-Disks" {
  description = "The managed disk names for the Linux VMs."
  value       = module.datadisk-n01669400.linux_managed_disk_names
}

output "Windows-Disk" {
  description = "The managed disk name for the Windows VM."
  value       = module.datadisk-n01669400.windows_managed_disk_name
}

# Output the name of the load balancer
output "loadbalancer_name" {
  value = module.loadbalancer-n01669400.lb_name
}

# Output the name of the database
output "Database" {
  value = module.database-n01669400.db_name
}
