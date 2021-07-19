variable "location" {
    type = string
}

variable "sa_name" {
    type    = string
}

variable "example-resource" {
    type    = string
}


provider "azurerm" {
    features {}
}

module "storage" {
    source = "kumarvna/storage/azurerm"
    location = var.location
    storage_account_name = var.sa_name
    
}

resource "azurerm_resource_group" "example" {
    name = var.example-resource
    location = var.location
}



resource "azurerm_storage_account" "example" {
    name = "example_storage_account"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    account_tier = "Standard"
    account_replica
}