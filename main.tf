# Root module's main.tf

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Project"
    Name           = "srushti.jiyani"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}

# Define the Azure Resource Group
module "rgroup" {
  source              = "./modules/rgroup-n01669400"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.common_tags
}

# Define the Network
module "network" {
  source               = "./modules/network-n01669400"
  resource_group_name  = module.rgroup.resource_group_name
  location             = var.location
  virtual_network_name = "n9400-VNET"
  subnet_name          = "n9400-SUBNET"
  tags                 = local.common_tags
}

# Define the Azure Storage Account
module "common_services" {
  source                       = "./modules/common-n01669400"
  resource_group_name          = module.rgroup.resource_group_name
  location                     = var.location
  log_analytics_workspace_name = "n9400-LogAnalyticsWorkspace"
  recovery_services_vault_name = "n9400-RecoveryServicesVault"
  storage_account_name         = "n9400storageaccount"
  tags                         = local.common_tags
}

# Define the Azure Linux Virtual Machine
module "vmlinux" {
  source               = "./modules/vmlinux-n01669400"
  resource_group_name  = module.rgroup.resource_group_name
  location             = var.location
  prefix               = var.prefix
  subnet_id            = module.network.subnet_id
  storage_account_name = module.common_services.storage_account_name
  storage_account_key  = module.common_services.storage_account_primary_access_key
  vm_linux_size        = var.vm_linux_size
  tags                 = local.common_tags
}

#Define the Azure Windows Virtual Machine
module "vmwindows" {
  source               = "./modules/vmwindows-n01669400"
  resource_group_name  = module.rgroup.resource_group_name
  location             = var.location
  prefix               = var.prefix
  subnet_id            = module.network.subnet_id
  storage_account_name = module.common_services.storage_account_name
  storage_account_key  = module.common_services.storage_account_primary_access_key
  vm_win_size          = var.vm_win_size
  tags                 = local.common_tags
}

# Define the Azure Data Disk
module "datadisk" {
  source              = "./modules/datadisk-n01669400"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  linux_vm_ids        = module.vmlinux.vm_ids
  windows_vm_id       = module.vmwindows.vm_id
  prefix              = var.prefix
  tags                = local.common_tags
}

# Define the Azure Load Balancer
module "loadbalancer" {
  source              = "./modules/loadbalancer-n01669400"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  linux_vm_ids        = module.vmlinux.vm_ids
  linux_nic_ids       = module.vmlinux.linux_nic_ids
  prefix              = var.prefix
  tags                = local.common_tags
}

# Define the Azure Database
module "database" {
  source              = "./modules/database-n01669400"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  prefix              = var.prefix
  db_password         = var.db_password
  tags                = local.common_tags
}
