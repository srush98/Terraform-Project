# File: modules/common/outputs.tf

# Output the name of the log analytics workspace
output "log_analytics_workspace_name" {
  value       = azurerm_log_analytics_workspace.workspace.name
  description = "The name of the log analytics workspace."
}

# Output the name of the recovery services vault
output "recovery_services_vault_name" {
  value       = azurerm_recovery_services_vault.vault.name
  description = "The name of the recovery services vault."
}

# Output the name of the storage account
output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "The name of the storage account."
}

# Output the primary access key for the storage account
output "storage_account_primary_access_key" {
  description = "Primary access key for the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}
