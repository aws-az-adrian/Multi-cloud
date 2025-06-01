# NIC para Windows Server
resource "azurerm_network_interface" "nic_wserver-asir-2" {
  name                = "nic-wserver-asir-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet-asir-2.id
    private_ip_address_allocation = "Dynamic"
  }
}

# VM Windows Server (con AD y ZeroTier)
resource "azurerm_windows_virtual_machine" "wserver-asir-2" {
  name                  = "wserver-asir-2"
  resource_group_name   = azurerm_resource_group.rg-asir-2.name
  location              = var.location
  size                  = var.vm_size # Tamaño más barato
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_wserver-asir-2.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"  # Discos más baratos
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  provision_vm_agent = true

  custom_data = base64encode(file("${path.module}/../../scripts/install-zerotier.ps1"))
}

# NIC para Windows Cliente
resource "azurerm_network_interface" "nic_wclient-asir-2" {
  name                = "nic-wclient-asir-2"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet-asir-2.id
    private_ip_address_allocation = "Dynamic"
  }
}

# VM Windows Cliente (con ZeroTier)
resource "azurerm_windows_virtual_machine" "wclient-asir-2" {
  name                  = "wclient-asir-2"
  resource_group_name   = azurerm_resource_group.rg-asir-2.name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_wclient-asir-2.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"  # Discos más baratos
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-10"
    sku       = "win10-21h2-pro"
    version   = "latest"
  }

  provision_vm_agent = true

  custom_data = base64encode(file("${path.module}/../../scripts/install-zerotier.ps1"))
}