# Root module's main.tf

# Define the Azure Resource Group
module "rgroup-n01669400" {
  source = "./modules/rgroup-n01669400"
}

# Define the Network
module "network-n01669400" {
  source              = "./modules/network-n01669400"
  resource_group_name = module.rgroup-n01669400.resource_group_name
}

# Define the Azure Storage Account
module "common-n01669400" {
  source              = "./modules/common-n01669400"
  resource_group_name = module.rgroup-n01669400.resource_group_name
}

# Define the Azure Linux Virtual Machine
module "vmlinux-n01669400" {
  source               = "./modules/vmlinux-n01669400"
  resource_group_name  = module.rgroup-n01669400.resource_group_name
  storage_account_name = module.common-n01669400.storage_account_name
  storage_account_key  = module.common-n01669400.storage_account_primary_access_key
  subnet_id            = module.network-n01669400.subnet_id
}

#Define the Azure Windows Virtual Machine
module "vmwindows-n01669400" {
  source               = "./modules/vmwindows-n01669400"
  resource_group_name  = module.rgroup-n01669400.resource_group_name
  subnet_id            = module.network-n01669400.subnet_id
  storage_account_name = module.common-n01669400.storage_account_name
  storage_account_key  = module.common-n01669400.storage_account_primary_access_key
}

# Define the Azure Data Disk
module "datadisk-n01669400" {
  source              = "./modules/datadisk-n01669400"
  resource_group_name = module.rgroup-n01669400.resource_group_name
  linux_vm_ids        = module.vmlinux-n01669400.vm_ids
  windows_vm_id       = module.vmwindows-n01669400.vm_id
}



# Define the Azure Database
module "database-n01669400" {
  source              = "./modules/database-n01669400"
  resource_group_name = module.rgroup-n01669400.resource_group_name
  db_password         = "YourSecurePassword123!"
}
