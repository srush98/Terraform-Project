# File: main module's outputs.tf

# Output the name of the resource group
output "Resource-Group" {
  value = module.rgroup.resource_group_name
}

# Output the name of the virtual network
output "Virtual-Network" {
  value = module.network.virtual_network_name
}

# Output the name of the subnet
output "Subnet" {
  value = module.network.subnet_name
}

# Output the name of the log analytics workspace
output "Log_analytics_workspace" {
  value = module.common_services.log_analytics_workspace_name
}

# Output the name of the recovery services vault
output "Recovery_services_vault" {
  value = module.common_services.recovery_services_vault_name
}

# Output the name of the storage account
output "Storage_Account" {
  value = module.common_services.storage_account_name
}

# Output the information of the Linux VM
output "Linux_VM_info" {
  description = "Linux VM information"
  value = {
    hostnames    = module.vmlinux.linux_vm_hostnames
    domain_names = module.vmlinux.linux_vm_domain_names
    private_ips  = module.vmlinux.linux_vm_private_ips
    public_ips   = module.vmlinux.linux_vm_public_ips
  }
}

# Output the information of the Windows VM
output "Windows_VM_info" {
  description = "Windows VM information"
  value = {
    hostname    = module.vmwindows.hostname
    domain_name = module.vmwindows.domain_name
    private_ip  = module.vmwindows.private_ip
    public_ip   = module.vmwindows.public_ip
  }
}

# Output the name of the load balancer
output "Loadbalancer-Name" {
  value = module.loadbalancer.lb_name
}

# Output the name of the database
output "Database-Name" {
  value = module.database.db_name
}
