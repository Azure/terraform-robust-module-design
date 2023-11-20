# Using an arbitrary map key is the most robust way of avoiding errors with for_each expressions.
locals {
  map_of_objects = {
    unused1 = {
      name = "foo"
      attr = "foo2"
    }
    unused2 = {
      name = "bar"
      attr = "bar2"
    }
  }
}

resource "terraform_data" "map_of_objects" {
  for_each = local.map_of_objects
  input = {
    name = each.value.name
    attr = each.value.attr
  }
}
