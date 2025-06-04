# Public IP para Windows Server
resource "azurerm_public_ip" "wserver-publicip" {
  name                = "wserver-publicip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name
  allocation_method   = "Static"
}

# Public IP para Windows Cliente
resource "azurerm_public_ip" "wclient-publicip" {
  name                = "wclient-publicip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name
  allocation_method   = "Static"
}

# NIC para Windows Server
resource "azurerm_network_interface" "nic_wserver-asir-2" {
  name                = "nic-wserver-asir-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet-asir-2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wserver-publicip.id
  }

  tags = {
    Name = "nic-wserver-asir-2"
  }
}

# NIC para Windows Cliente
resource "azurerm_network_interface" "nic_wclient-asir-2" {
  name                = "nic-wclient-asir-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet-asir-2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wclient-publicip.id
  }
}

# VM Windows Server (con AD y ZeroTier)
resource "azurerm_windows_virtual_machine" "wserver-asir-2" {
  name                  = "wserver-asir-2"
  resource_group_name   = azurerm_resource_group.rg-asir-2.name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username_server
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_wserver-asir-2.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.server_image_publisher
    offer     = var.server_image_offer
    sku       = var.server_image_sku
    version   = var.server_image_version
  }

  provision_vm_agent = true



  identity {
    type = "SystemAssigned"
  }
}

# VM Windows Cliente (con ZeroTier)
resource "azurerm_windows_virtual_machine" "wclient-asir-2" {
  name                  = "wclient-asir-2"
  resource_group_name   = azurerm_resource_group.rg-asir-2.name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username_client
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic_wclient-asir-2.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.client_image_publisher
    offer     = var.client_image_offer
    sku       = var.client_image_sku
    version   = var.client_image_version
  }

  provision_vm_agent = true
}

# Outputs de IP Pública
output "wserver_public_ip" {
  value = azurerm_public_ip.wserver-publicip.ip_address
}

output "wclient_public_ip" {
  value = azurerm_public_ip.wclient-publicip.ip_address
}


resource "azurerm_virtual_machine_extension" "zerotier_install_server" {
  name                 = "zerotier-install"
  virtual_machine_id   = azurerm_windows_virtual_machine.wserver-asir-2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    fileUris         = ["https://raw.githubusercontent.com/aws-az-adrian/Multi-cloud/refs/heads/main/scripts/install-zerotier.ps1"]
    commandToExecute = "powershell -ExecutionPolicy Unrestricted -File install-zerotier.ps1"
  })

  depends_on = [azurerm_windows_virtual_machine.wserver-asir-2]
}

resource "azurerm_virtual_machine_extension" "zerotier_install_client" {
  name                 = "zerotier-install"
  virtual_machine_id   = azurerm_windows_virtual_machine.wclient-asir-2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    fileUris         = ["https://raw.githubusercontent.com/aws-az-adrian/Multi-cloud/refs/heads/main/scripts/install-zerotier.ps1"]
    commandToExecute = "powershell -ExecutionPolicy Unrestricted -File install-zerotier.ps1"
  })

  depends_on = [azurerm_windows_virtual_machine.wclient-asir-2]
}