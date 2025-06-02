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

# NSG para permitir WinRM
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-asir-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-asir-2.name
}

resource "azurerm_network_security_rule" "allow_winrm" {
  name                        = "Allow-WinRM"
  priority                    = 1010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5986"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-asir-2.name
  network_security_group_name = azurerm_network_security_group.nsg.name
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

  network_security_group_id = azurerm_network_security_group.nsg_asir_2.id
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

  network_security_group_id = azurerm_network_security_group.nsg_asir_2.id
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

  custom_data = base64encode(file("${path.module}/../../scripts/install-zerotier.ps1"))

  identity {
    type = "SystemAssigned"
  }
}

# Extensión para habilitar WinRM
resource "azurerm_virtual_machine_extension" "enable_winrm" {
  name                 = "enableWinRM"
  virtual_machine_id   = azurerm_windows_virtual_machine.wserver-asir-2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
{
  "commandToExecute": "powershell -Command \"Enable-PSRemoting -Force; Set-Item -Path WSMan:\\\\localhost\\Service\\AllowUnencrypted -Value $true; winrm set winrm/config/service/auth '@{Basic=\\\"true\\\"}'; New-SelfSignedCertificate -DnsName 'localhost' -CertStoreLocation Cert:\\\\LocalMachine\\\\My\""
}
SETTINGS
}

# Provisioner para copiar el archivo PEM a la VM Windows Server
resource "null_resource" "copy_pem_to_windows" {
  provisioner "file" {
    source      = "${path.module}/keys/my-key-asir.pem"
    destination = "C:/Users/${var.admin_username_server}/Desktop/my-key-asir.pem"

    connection {
      type     = "winrm"
      user     = var.admin_username_server
      password = var.admin_password
      host     = azurerm_public_ip.wserver-publicip.ip_address
      port     = 5986
      https    = true
      insecure = true
    }
  }

  depends_on = [
    azurerm_windows_virtual_machine.wserver-asir-2,
    azurerm_virtual_machine_extension.enable_winrm
  ]
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
  # custom_data = base64encode(file("${path.module}/../../scripts/install-zerotier.ps1"))
}

# Outputs de IP Pública
output "wserver_public_ip" {
  value = azurerm_public_ip.wserver-publicip.ip_address
}

output "wclient_public_ip" {
  value = azurerm_public_ip.wclient-publicip.ip_address
}

## ACTIVE DIRECTORY INTEGRATION

resource "azuread_group" "vm_access_group" {
  display_name     = "group-ad-asir-2"
  security_enabled = true
}

resource "data" "azuread_user" "vm_user" {
  user_principal_name = "pepe@adrianvilchezgonzalez1outlo.onmicrosoft.com"
}

resource "azuread_group_member" "add_user_to_group" {
  group_object_id  = azuread_group.vm_access_group.object_id
  member_object_id = data.azuread_user.vm_user.object_id
}

resource "azurerm_virtual_machine_extension" "aad_login_windows" {
  name                       = "AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.wserver-asir-2.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_role_assignment" "vm_login_manage" {
  scope                = azurerm_windows_virtual_machine.wserver-asir-2.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = azuread_group.vm_access_group.object_id
}

data "azuread_group" "vm_access_group" {
  object_id = azuread_group.vm_access_group.object_id
}