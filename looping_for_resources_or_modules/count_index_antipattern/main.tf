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
    {                                    # run apply, then comment out this object and run apply again
      name = "${random_pet.name.id}-bar" # ...and you'll see that the resource is destroyed and recreated
      attr = "bar2"                      # ...because the name value of the object at list index 1 changed
    },
    {
      name = "${random_pet.name.id}-baz"
      attr = "baz2"
    },
  ]

  # This simulates some more data that might be returned from an external data source/lookup
  list_of_objects_data = [
    "data1",
    "data2",
    "data3"
  ]
}


# This works, but what happens when you apply the config, then remove the second element from the list_of_objects?
resource "terraform_data" "arrrgh_dont_do_this" {
  count = length(local.list_of_objects)
  input = {
    name = local.list_of_objects[count.index].name
    attr = local.list_of_objects[count.index].attr

    # This is looking up data from a separate list and is _really_ fragile.
    # If you do have to do this, make sure you use a for_each, then make sure the map key is consistent.
    attr2 = local.list_of_objects_data[count.index]
  }
  triggers_replace = local.list_of_objects[count.index].name
}
