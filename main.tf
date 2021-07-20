provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "my_az_rg" {
  name     = var.azurerm_resource_group_name
  location = var.azurerm_resource_group_loaction
}

variable "azurerm_resource_group_name" {
  type = string
  description = "azurerm_resource_group_name"
}

variable "azurerm_resource_group_loaction" {
  type = string
  description = "azurerm_resource_group_loaction"
}


resource "azurerm_virtual_network" "my_az_vnet" {
  name                = var.azurerm_virtual_network_name
  address_space       = var.azurerm_virtual_network_add_spc
  location            = azurerm_resource_group.my_az_rg.location
  resource_group_name = azurerm_resource_group.my_az_rg.name
}

variable "azurerm_virtual_network_name" {
  type = string
  description = "azurerm_virtual_network_name"
}

variable "azurerm_virtual_network_add_spc" {
  type = list(string)
  description = "azurerm_virtual_network_address_space"
  # default = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "my_az_subnet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = azurerm_resource_group.my_az_rg.name
  virtual_network_name = azurerm_virtual_network.my_az_vnet.name
  address_prefixes     = var.azurerm_subnet_add_pre
}

variable "azurerm_subnet_name" {
  type = string
  description = "azurerm_subnet_name"
}

variable "azurerm_subnet_add_pre" {
  type = list(string)
  description = "azurerm_subnet_address_prefixes"
}


resource "azurerm_network_interface" "my_az_nic" {
  name                = var.azurerm_network_interface_name
  location            = azurerm_resource_group.my_az_rg.location
  resource_group_name = azurerm_resource_group.my_az_rg.name

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = azurerm_subnet.my_az_subnet.id
    private_ip_address_allocation = var.nic_private_ip_address_allocation
  }
}

variable "azurerm_network_interface_name" {
  type = string
  description = "azurerm_network_interface_name"
}

variable "nic_ip_configuration_name" {
  type = string
  description = "nic_ip_configuration_name"
}

variable "nic_private_ip_address_allocation" {
  type = string
  description = "nic_private_ip_address_allocation"
}
resource "azurerm_windows_virtual_machine" "myvm" {
  name                = var.azurerm_network_interface_name
  resource_group_name = azurerm_resource_group.my_az_rg.name
  location            = azurerm_resource_group.my_az_rg.location
  size                = var.azurerm_windows_virtual_machine_size
  admin_username      = var.azurerm_windows_virtual_machine_admin_username
  admin_password      = var.azurerm_windows_virtual_machine_admin_password
  network_interface_ids = [
    azurerm_network_interface.my_az_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "azurerm_windows_virtual_machine_name" {
  type = string
  description = "azurerm_windows_virtual_machine_name"
  }

variable "azurerm_windows_virtual_machine_size" {
  type = string
  description = "azurerm_windows_virtual_machine_size"
}

variable "azurerm_windows_virtual_machine_admin_username" {
  type = string
  description = "azurerm_windows_virtual_machine_admin_username"
}

variable "azurerm_windows_virtual_machine_admin_password" {
  type = string
  description = "azurerm_windows_virtual_machine_admin_password"
}