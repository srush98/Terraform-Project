# File: modules/vmlinux/variables.tf

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

variable "vm_linux_count" {
  type        = number
  description = "Number of Linux VMs to create"
  default     = 3
}

variable "vm_linux_size" {
  type        = string
  description = "The size of the Linux virtual machine."
  default     = "Standard_B1ms"
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

variable "linux_image" {
  type        = map(string)
  description = "Linux OS image details"
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}