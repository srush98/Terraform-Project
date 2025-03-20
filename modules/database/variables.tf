# File: modules/database-n01669400/variables.tf

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

variable "db_password" {
  description = "Administrator password for PostgreSQL database"
  type        = string
  sensitive   = true
}
