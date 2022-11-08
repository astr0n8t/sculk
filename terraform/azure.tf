# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "sculk" {
  name     = "sculk"
  location = "East US"
}