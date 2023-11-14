resource "random_pet" "name" {
  length = 1
}

# This simulates some data that might be returned from an external data source/lookup
locals {
  list_of_objects = [
    {
      name = "${random_pet.name.id}-foo"
      attr = "foo2"
    },
    {
      name = "${random_pet.name.id}-bar"
      attr = "bar2"
    },
    {
      name = "${random_pet.name.id}-baz"
      attr = "baz2"
    },
  ]
  list_of_objects_data = [
    "data1",
    "data2",
    "data3"
  ]
}

resource "terraform_data" "arrrgh_dont_do_this" {
  count = length(local.list_of_objects)
  input = {
    name = local.list_of_objects[count.index].name
    attr = local.list_of_objects[count.index].attr

    # This is _really_ horrible, do not do this!
    attr2 = local.list_of_objects_data[count.index]
  }
}
