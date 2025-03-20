# File: modules/datadisk/variables.tf

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

variable "storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Type of storage account to use"
}

variable "linux_vm_ids" {
  type        = list(string)
  description = "IDs of the Linux VMs"
}

variable "windows_vm_id" {
  type        = string
  description = "ID of the Windows VM"
}
