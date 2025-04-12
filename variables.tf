# File: variables.tf

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "n9400-RG"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
  default     = "Canada Central"
}

variable "prefix" {
  type    = string
  default = "n9400"
}

variable "db_password" {
  description = "The database administrator password"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd1234!"
}

variable "vm_linux_size" {
  type        = string
  description = "The size of the Linux virtual machine."
  default     = "Standard_B1ms"
}

variable "vm_win_size" {
  type        = string
  description = "The size of the Windows virtual machine."
  default     = "Standard_B1ms"
}