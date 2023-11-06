locals {
  map_of_objects = {
    foo = {
      name = "foo"
      attr = "foo2"
    }
    bar = {
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
