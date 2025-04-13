# File: modules/database/outputs.tf

# Output the name of the database
output "db_name" {
  value = azurerm_postgresql_server.db.name
}
