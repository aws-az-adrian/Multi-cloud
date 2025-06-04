terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0" # o la más reciente compatible
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
  use_cli = true
}