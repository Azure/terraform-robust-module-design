
locals {
  create_resource = true
  conditional_key = "enabled"
}

resource "terraform_data" "conditional" {
  for_each = local.create_resource ? toset([local.conditional_key]) : toset([])
  input    = "foo"
}

output "example" {
  value       = try(terraform_data.conditional[local.conditional_key].output, null)
  description = "Shows example of using map key to return a single instance."
}
