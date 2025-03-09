# File: main module's outputs.tf

# Output the name of the resource group
output "RG-name" {
  value = module.rgroup-9400.resource_group_name
}

# Output the name of the virtual network
output "Vnet-name" {
  value = module.network-9400.virtual_network_name
}

# Output the name of the subnet
output "Subnet-name" {
  value = module.network-9400.subnet_name
}

# Output the name of the log analytics workspace
output "Log_analytics_workspace_name" {
  value = module.common-9400.log_analytics_workspace_name
}

# Output the name of the recovery services vault
output "Recovery_services_vault_name" {
  value = module.common-9400.recovery_services_vault_name
}

# Output the name of the storage account
output "Storage_account_name" {
  value = module.common-9400.storage_account_name
}

# Output the information of the Linux VM
output "Linux_VM_info" {
  description = "Linux VM information"
  value = {
    hostnames    = module.vmlinux-9400.linux_vm_hostnames
    domain_names = module.vmlinux-9400.linux_vm_domain_names
    private_ips  = module.vmlinux-9400.linux_vm_private_ips
    public_ips   = module.vmlinux-9400.linux_vm_public_ips
  }
}

# Output the information of the Windows VM
output "Windows_VM_info" {
  description = "Windows VM information"
  value = {
    hostname    = module.vmwindows-9400.hostname
    domain_name = module.vmwindows-9400.domain_name
    private_ip  = module.vmwindows-9400.private_ip
    public_ip   = module.vmwindows-9400.public_ip
  }
}

output "Linux-Disks" {
  description = "The managed disk names for the Linux VMs."
  value       = module.datadisk-9400.linux_managed_disk_names
}

output "Windows-Disk" {
  description = "The managed disk name for the Windows VM."
  value       = module.datadisk-9400.windows_managed_disk_name
}

# Output the name of the load balancer
#output "loadbalancer_name" {
#  value = module.loadbalancer-9400.lb_name
#}

# Output the name of the database
output "database-name" {
  value = module.database-9400.db_name
}
