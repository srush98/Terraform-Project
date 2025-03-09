variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "9400-RG"
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
  default = "9400"
}

variable "linux_vm_ids" {
  type        = list(string)
  description = "IDs of the Linux VMs"
}

variable "linux_nic_ids" {
  description = "List of Linux VM network interface IDs"
  type        = list(string)
}
