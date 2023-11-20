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
    {                                    # run apply, then comment out this object and run plan
      name = "${random_pet.name.id}-bar" # ...and you'll see that other resources are destroyed and recreated
      attr = "bar2"                      # ...because the name value of the object at list indices 1 & 2 changed
    },                                   # ...
    {
      name = "${random_pet.name.id}-baz"
      attr = "baz2"
    },
    {
      name = "${random_pet.name.id}-fiz"
      attr = "fiz2"
    },
  ]

  # This simulates some more data that might be returned from an external data source/lookup
  # and is a very bad idea.
  # Trying to ensure consistent ordering of data in multiple lists is error prone.
  list_of_objects_data = [
    "data1",
    "data2",
    "data3",
    "data4"
  ]
}


# This works, but what happens when you apply the config, then remove the second element from the list_of_objects?
resource "terraform_data" "arrrgh_dont_do_this" {
  count = length(local.list_of_objects)
  input = {
    name = local.list_of_objects[count.index].name
    attr = local.list_of_objects[count.index].attr

    # This is looking up data from a separate list and is _really_ fragile.
    # If you do have to use more than one daya object to retrieve data for a resource,
    # then you should use maps and ensure the keys are consistent and match those used in the
    # for_each loop on the resource.
    attr2 = local.list_of_objects_data[count.index]
  }
  # This simulates a real cloud resource, where a change of a key attribute will cause the resource to be destroyed and re-created.
  triggers_replace = local.list_of_objects[count.index].name
}
