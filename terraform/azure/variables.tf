variable "resource_group_name" {
  description = "Nombre del grupo de recursos en Azure"
  type        = string
}

variable "location" {
  description = "Ubicación geográfica de los recursos"
  type        = string
}

variable "admin_username_server" {
  description = "Nombre del usuario administrador para las máquinas virtuales"
  type        = string
}

variable "admin_username_client" {
  description = "Nombre del usuario administrador para las máquinas virtuales"
  type        = string
}
variable "admin_password" {
  description = "Contraseña del administrador (necesaria para Windows)"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Tamaño de las máquinas virtuales"
  type        = string
}

# Imagen para Windows Server
variable "server_image_publisher" {
  description = "Publisher de la imagen de la VM Windows Server"
  type        = string
}

variable "server_image_offer" {
  description = "Tipo de oferta de la imagen Windows Server"
  type        = string
}

variable "server_image_sku" {
  description = "SKU de la imagen Windows Server"
  type        = string
}

variable "server_image_version" {
  description = "Versión de la imagen Windows Server"
  type        = string
}

# Imagen para Windows Cliente
variable "client_image_publisher" {
  description = "Publisher de la imagen de la VM Windows Cliente"
  type        = string
}

variable "client_image_offer" {
  description = "Tipo de oferta de la imagen Windows Cliente"
  type        = string
}

variable "client_image_sku" {
  description = "SKU de la imagen Windows Cliente"
  type        = string
}

variable "client_image_version" {
  description = "Versión de la imagen Windows Cliente"
  type        = string
}


    # publisher = "MicrosoftWindowsDesktop"
    # offer     = "windows-10"
    # sku       = "win10-21h2-pro"
    # version   = "latest"