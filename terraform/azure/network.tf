resource "azurerm_virtual_network" "vnet-asir-2" {
  name                = "vnet-asir-2"
  address_space       = ["192.168.2.0/24"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name
}

resource "azurerm_subnet" "subnet-asir-2" {
  name                 = "subnet-asir-2"
  resource_group_name  = azurerm_resource_group.rg-asir-2.name
  virtual_network_name = azurerm_virtual_network.vnet-asir-2.name
  address_prefixes     = ["192.168.2.0/25"] 
}