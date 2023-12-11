# This simulates the common situation where an incoming
# resource id is used as a condition in a count expression.
# It is not known until after apply.
resource "random_pet" "resource_reference" {
  length = 1
}

# We wrap the resource id in an object to allow it to be
# evaluated as null or not null at plan time.
# (this would be an object variable with `default = null` in a real module)
locals {
  resource_id = {
    id = random_pet.resource_reference.id
  }
}

# This will work because the count expression
# be evaluated at plan time as the object is known,
# even if the `id` value is not.
resource "terraform_data" "this_works" {
  count = local.resource_id != null ? 1 : 0
  input = local.resource_id.id
}
