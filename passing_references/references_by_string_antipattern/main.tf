# This simulates the common situation where an incoming
# resource id is used as a condition in a count expression.
# It is not known until after apply.
resource "random_pet" "resource_reference" {
  length = 1
}

# This will fail because the count expression cannot
# be evaluated at plan time.
resource "terraform_data" "oops" {
  count = random_pet.resource_reference.id == null ? 1 : 0
  input = "foo"
}
