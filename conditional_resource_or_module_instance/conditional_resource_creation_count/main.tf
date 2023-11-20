variable "my_input" {
  type = string
  default = null
  description = "Shows conditional resource creation using count with null test."
}

locals {
  create_resource = true
}

resource "terraform_data" "conditional_boolean" {
  count = local.create_resource ? 1 : 0
  input = "foo"
}

resource "terraform_data" "conditional_null_string" {
  count = var.my_input == null ? 1 : 0
  input = "foo"
}

output "conditional_boolean" {
  value       = try(one(terraform_data.conditional_boolean).output, null)
  description = "Shows example of using one() function to return a single instance."
}

output "conditional_null_string" {
  value       = try(one(terraform_data.conditional_null_string).output, null)
  description = "Shows example of using one() function to return a single instance."
}
