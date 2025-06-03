resource "azurerm_network_security_group" "nsg_asir_2" {
  name                = "nsg-asir-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-ICMP"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_wserver" {
  network_interface_id      = azurerm_network_interface.nic_wserver-asir-2.id
  network_security_group_id = azurerm_network_security_group.nsg_asir_2.id
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_wclient" {
  network_interface_id      = azurerm_network_interface.nic_wclient-asir-2.id
  network_security_group_id = azurerm_network_security_group.nsg_asir_2.id
}