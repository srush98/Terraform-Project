# File: variables.tf

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

variable "prefix" {
  type    = string
  default = "n9400"
}
