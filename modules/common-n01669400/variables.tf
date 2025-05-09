# File: modules/common/variables.tf
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

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace."
}

variable "recovery_services_vault_name" {
  type        = string
  description = "The name of the recovery services vault."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
}
