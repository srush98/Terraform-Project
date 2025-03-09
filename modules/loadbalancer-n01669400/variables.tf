# File: modules/loadbalancer-n01669400/variables.tf

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

variable "linux_vm_ids" {
  type        = list(string)
  description = "IDs of the Linux VMs"
}

variable "linux_nic_ids" {
  description = "List of Linux VM network interface IDs"
  type        = list(string)
}
