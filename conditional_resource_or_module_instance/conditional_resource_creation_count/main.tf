
locals {
  create_resource = true
}

resource "terraform_data" "conditional" {
  count = local.create_resource ? 1 : 0
  input = "foo"
}

output "example" {
  value       = try(one(terraform_data.conditional).output, null)
  description = "Shows example of using one() function to return a single instance."
}
