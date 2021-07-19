resource "azurerm_resource_group" "az_rg_name" {
  name = var.az_rg_name
  location = var.az_rg_reg
}