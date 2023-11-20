# Here we use a boolean value to simulate the condition of a variable being set to true or false.
# We use this in the `terraform_data.conditional_boolean` resource to conditionally create the resource.
locals {
  create_resource = true
}

# It is also common to use a null test for resource creation.
# Here we show how to conditionally create a resource if the caller does not override a variable default.
# We use this in the `terraform_data.conditional_null_string` resource to conditionally create the resource.
variable "my_input" {
  type = string
  default = null
  description = "Shows conditional resource creation using count with null test."
}

# This resource will only be created if the `create_resource` local is set to true.
resource "terraform_data" "conditional_boolean" {
  count = local.create_resource ? 1 : 0
  input = "foo"
}

# This resource will only be created if the `my_input` variable is `null`.
resource "terraform_data" "conditional_null_string" {
  count = var.my_input == null ? 1 : 0
  input = "foo"
}

# In this output, the `one()` function is helpful to get the zeroth index of the resource.
# We also need to use try to cater for the case where the resource is not created.
output "conditional_boolean" {
  value       = try(one(terraform_data.conditional_boolean).output, null)
  description = "Shows example of using one() function to return a single instance."
}

# In this output, the `one()` function is helpful to get the zeroth index of the resource.
# We also need to use try to cater for the case where the resource is not created.
output "conditional_null_string" {
  value       = try(one(terraform_data.conditional_null_string).output, null)
  description = "Shows example of using one() function to return a single instance."
}
