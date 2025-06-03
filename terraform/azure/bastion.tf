resource "azurerm_public_ip" "bastion_ip-asir-2" {
  name                = "bastion-ip-asir-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet-asir-2.id
    public_ip_address_id = azurerm_public_ip.bastion_ip-asir-2.id
  }

  depends_on = [azurerm_subnet.bastion-subnet-asir-2]
}
