# File: modules/network-n01669400/variables.tf

# Define input variables for the network module
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

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "n9400-VNET"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = "n9400-SUBNET"
}
