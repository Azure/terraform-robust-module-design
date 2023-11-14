resource "random_pet" "name" {
  length = 1
}

# This simulates some data that might be returned from an external data source/lookup
locals {
  set_of_objects = toset([
    {
      name = "${random_pet.name.id}-foo"
      attr = "foo2"
    },
    {
      name = "${random_pet.name.id}-bar"
      attr = "bar2"
    },
  ])
}

# This errors because the for_each expression contains map keys that are not known in advance.
resource "terraform_data" "map_of_objects" {
  for_each = { for obj in local.set_of_objects : obj.name => obj }
  input = {
    name = each.key
    attr = each.value.attr
  }
}
