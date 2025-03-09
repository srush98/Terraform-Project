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

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace."
  default     = "9400-LogAnalyticsWorkspace"
}

variable "recovery_services_vault_name" {
  type        = string
  description = "The name of the recovery services vault."
  default     = "n01669400-RecoveryServicesVault"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
  default     = "n01669400storageaaccount"
}
