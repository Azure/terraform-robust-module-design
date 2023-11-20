provider "azurerm" {
  features {}
}

# These resources ensure we deploy to a random region and use a random suffix for our resource names
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

# This is the interesting part of the example
resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = module.regions.regions[random_integer.region_index.result].name
}

locals {
  address_prefix = "192.168.0.0/16"
  subnets = toset([
    {
      name           = "subnet1"
      address_prefix = cidrsubnet(local.address_prefix, 8, 0)
    },
    {
      name           = "subnet3"
      address_prefix = cidrsubnet(local.address_prefix, 8, 2)
    },
  ])
}

resource "azurerm_virtual_network" "example" {
  name                = module.naming.virtual_network.name
  address_space       = [local.address_prefix]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Here we use a set of objects to create multiple subnets.
  # For dynamics we don't needs to use a map, or a set of strings like we do for resources & modules.
  dynamic "subnet" {
    for_each = local.subnets
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }
}
