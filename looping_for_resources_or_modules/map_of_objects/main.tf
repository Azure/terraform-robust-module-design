# Using an arbitrary map key is the most robust way of avoiding errors with for_each expressions.
locals {
  map_of_objects = {
    foo = {
      name = random_pet.name["foo"].id
      attr = "foo1"
    }
    bar = {
      name = random_pet.name["bar"].id
      attr = "bar1"
    }
  }
}

# Here we simulate values that aren't known until apply time.
resource "random_pet" "name" {
  for_each = toset(["foo", "bar"])
  length   = 2
}

resource "terraform_data" "map_of_objects" {
  for_each = local.map_of_objects
  input = {
    name = each.value.name
    attr = each.value.attr
  }
}
