provider "azurerm" {
  features {}
}

module "regions" {
  source  = "Azure/regions/azurerm"
  version = ">= 0.4.0"
}

resource "random_integer" "region_index" {
  min = 0
  max = length(module.regions.regions) - 1
}

resource "random_pet" "example" {
  length = 2
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.4.0"
  suffix  = [random_pet.example.id]
}

resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = module.regions.regions[random_integer.region_index.result].name
}

locals {
  subnets = toset([{
    name           = "subnet1"
    address_prefix = cidrsubnet(module.naming.virtual_network.address_space[0], 8, 0)
  }])
}


resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network.name
  address_space       = ["192.168.0.0/24"]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location


}
