variable "resource_group_name" {
  description = "Nombre del grupo de recursos en Azure"
  type        = string
}

variable "location" {
  description = "Ubicación geográfica de los recursos"
  type        = string
}

variable "admin_username" {
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

variable "image_publisher" {
  description = "Publisher de la imagen de la VM"
  type        = string
}

variable "image_offer" {
  description = "Tipo de oferta de imagen (Windows Server, etc.)"
  type        = string
}

variable "image_sku" {
  description = "SKU de la imagen (versión específica)"
  type        = string

}

variable "image_version" {
  description = "Versión de la imagen (latest suele funcionar)"
  type        = string
}





    # publisher = "MicrosoftWindowsDesktop"
    # offer     = "windows-10"
    # sku       = "win10-21h2-pro"
    # version   = "latest"