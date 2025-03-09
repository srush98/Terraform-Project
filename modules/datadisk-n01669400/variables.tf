# File: modules/datadisk-n01669400/variables.tf

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "n01669400-RG"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
  default     = "canadacentral"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources."
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "srushti.jiyani"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

variable "prefix" {
  type    = string
  default = "n01669400"
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
