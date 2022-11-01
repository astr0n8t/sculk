resource "azurerm_network_security_group" "vpn-nsg" {
  name                = "VPN-NSG"
  location            = azurerm_resource_group.sculk.location
  resource_group_name = azurerm_resource_group.sculk.name

  security_rule {
    name                       = "Allow_SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_WireGuard"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "51820"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}