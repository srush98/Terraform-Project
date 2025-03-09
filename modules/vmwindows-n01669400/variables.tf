# File: modules/vmwindows-n01669400/variables.tf

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "n9400-RG"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
  default     = "canadacentral"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources."
}

variable "prefix" {
  type    = string
  default = "n9400"
}

variable "subnet_id" {
  description = "The ID of the subnet where the Linux VMs will be deployed."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account for boot diagnostics"
  type        = string
}

variable "storage_account_key" {
  type        = string
  sensitive   = true
  description = "Primary access key of the storage account for boot diagnostics"
}

# Define the administrator password for the Windows VM
variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Administrator password for Windows VM"
  default     = "YourSecurePassword123!"
}

# Define the number of Windows VMs to create
variable "vm_count" {
  type        = number
  default     = 1
  description = "Number of Windows VMs to create"
}
