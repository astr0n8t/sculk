terraform {
  cloud {
    organization = "astr0n8t"

    workspaces {
      name = "sculk"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  } 
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "sculk" {
  name     = "skulk"
  location = "East US"
}