resource "azurerm_storage_account" "az_storage_account" {
  name = var.az_storage_account_name
  account_tier = var.az_storage_account_tier
  account_replication_type = var.az_storage_account_replication_type
}