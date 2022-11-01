resource "azurerm_network_interface" "wan" {
  name                = "wan-nic"
  location            = azurerm_resource_group.sculk.location
  resource_group_name = azurerm_resource_group.sculk.name

  ip_configuration {
    name                          = "wan"
    subnet_id                     = azurerm_subnet.sculk-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vpn-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vpn" {
  name                = "vpn-01"
  resource_group_name = azurerm_resource_group.sculk.name
  location            = azurerm_resource_group.sculk.location
  size                = "Standard_B1s"
  admin_username      = "astr0n8t"
  network_interface_ids = [
    azurerm_network_interface.wan.id,
  ]

  admin_ssh_key {
    username   = "astr0n8t"
    public_key = file("../id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-minimal-jammy"
    sku       = "minimal-22_04-lts"
    version   = "latest"
  }
}