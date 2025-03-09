# File: modules/vmwindows-n01669400/variables.tf

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources."
}

variable "prefix" {
  type = string
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
variable "vm_win_count" {
  type        = number
  default     = 1
  description = "Number of Windows VMs to create"
}

# Define the size of the Windows VM
variable "vm_size" {
  type        = string
  description = "Size of the Windows VMs"
  default     = "Standard_B1ms"
}

variable "storage_type" {
  type        = string
  description = "Storage type for OS disk"
  default     = "Standard_LRS"
}
