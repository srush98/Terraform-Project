# File: modules/database-n01669400/main.tf

# Define the Azure PostgreSQL Database Server

resource "azurerm_postgresql_server" "db" {
  name                = "${lower(replace(var.prefix, "-", ""))}psql"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = "B_Gen5_1"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = var.db_password
  version                      = "11"
  ssl_enforcement_enabled      = true

  tags = var.tags
}

# Define the Azure PostgreSQL Database
resource "azurerm_postgresql_database" "db" {
  name                = "project-db"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
