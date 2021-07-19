provider "azurerm" {
  features {}
}

module "rg" {
  source = "./rg"
  name = var.az_rg_name
  location = var.az_rg_reg
}

module "storage_account" {
  source = "./storage_account"
  name = var.az_storage_account_name
  account_tier = var.az_storage_account_tier
  account_replication_type = var.az_storage_account_replication_type
  resource_group_name  = module.rg.azurerm_resource_group.name
  location = module.rg.azurerm_resource_group.location
}