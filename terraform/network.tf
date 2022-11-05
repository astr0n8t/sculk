resource "azurerm_virtual_network" "sculk-network" {
  name                = "sculk-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.sculk.location
  resource_group_name = azurerm_resource_group.sculk.name
}

resource "azurerm_subnet" "sculk-subnet" {
  name                 = "sculk-subnet"
  resource_group_name  = azurerm_resource_group.sculk.name
  virtual_network_name = azurerm_virtual_network.sculk-network.name
  address_prefixes     = ["10.0.71.0/24"]
}

resource "azurerm_public_ip" "sculk-pip" {
  name                    = "sculk-pip"
  location                = azurerm_resource_group.sculk.location
  resource_group_name     = azurerm_resource_group.sculk.name
  allocation_method       = "Dynamic"
}

data "azurerm_public_ip" "sculk-pip" {
  name                = azurerm_public_ip.sculk-pip.name
  resource_group_name = azurerm_linux_virtual_machine.sculk.resource_group_name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.sculk-pip.ip_address
}