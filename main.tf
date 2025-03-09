# Root module's main.tf

# Define the Azure Resource Group
module "rgroup-9400" {
  source = "./modules/rgroup-9400"
}

# Define the Network
module "network-9400" {
    source = "./modules/network-9400"
    resource_group_name = module.rgroup-9400.resource_group_name
}

# Define the Azure Storage Account
module "common-9400" {
  source              = "./modules/common-9400"
  resource_group_name = module.rgroup-9400.resource_group_name
}

# Define the Azure Linux Virtual Machine
module "vmlinux-9400" {
  source               = "./modules/vmlinux-9400"
  resource_group_name  = module.rgroup-9400.resource_group_name
  storage_account_name = module.common-9400.storage_account_name
  storage_account_key  = module.common-9400.storage_account_primary_access_key
  subnet_id            = module.network-9400.subnet_id
}

#Define the Azure Windows Virtual Machine
module "vmwindows-9400" {
  source               = "./modules/vmwindows-9400"
  resource_group_name  = module.rgroup-9400.resource_group_name
  subnet_id            = module.network-9400.subnet_id
  storage_account_name = module.common-9400.storage_account_name
  storage_account_key  = module.common-9400.storage_account_primary_access_key
}

# Define the Azure Data Disk
module "datadisk-9400" {
  source              = "./modules/datadisk-9400"
  resource_group_name = module.rgroup-9400.resource_group_name
  linux_vm_ids        = module.vmlinux-9400.vm_ids
  windows_vm_id       = module.vmwindows-9400.vm_id
}



# Define the Azure Database
module "database-9400" {
  source              = "./modules/database-9400"
  resource_group_name = module.rgroup-9400.resource_group_name
  db_password         = "YourSecurePassword123!"
}
