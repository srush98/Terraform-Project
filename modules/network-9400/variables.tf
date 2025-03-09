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

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "n01669400-VNET"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = "n01669400-SUBNET"
}