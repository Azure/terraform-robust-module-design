# Here we show an input variable with a nested map type.
# We have supplied a default value for the variable.
variable "nested_map" {
  type = map(object({
    name = string
    child_map = map(object({
      child_name = string
    }))
  }))
  default = {
    first_parent = {
      name = "first_parent"
      child_map = {
        first_child = {
          child_name = "first_child_from_first_parent"
        }
        second_child = {
          child_name = "second_child_from_first_parent"
        }
      }
    }
    second_parent = {
      name = "second_parent"
      child_map = {
        first_child = {
          child_name = "first_child_from_second_parent"
        }
        second_child = {
          child_name = "second_child_from_second_parent"
        }
      }
    }
  }
}

# Here we use a local value to flatten the nested map into a single map.
# We use nested for loops to iterate over parent map variable, then again over the child map variable.
#
locals {
  flattened_map = {
    for item in flatten( # 4. We use the flatten function to flatten the nested list into a single list.
      [
        for parent_key, parent_value in var.nested_map : [         # 1. We create a list using a for expression over the parent map variable. Each list item is another list, which we will flatten later.
          for child_key, child_value in parent_value.child_map : { # 2. We create a nested list using a for expression over the child map variable.
            parent_key  = parent_key                               # 3. Each list item is an object with the following attributes:
            child_key   = child_key                                #    The parent and child keys are needed to construct the resultant map key.
            child_value = child_value                              #    The child value is used to construct the resultant map value.
          }
        ]
      ]
    ) : "${item.parent_key}/${item.child_key}" => item.child_value # 5. We use the other half of the for expression to construct the resultant map.
  }                                                                #    The key is constructed using the parent and child keys and the value is the child value.
}

# Here we use a for expression to safely iterate over the flattened map.
resource "terraform_data" "nested_map" {
  for_each = local.flattened_map

  input = each.value.child_name
}
