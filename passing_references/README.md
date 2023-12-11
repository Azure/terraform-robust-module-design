# Passing references

- [back home](../)

This pattern shows how to pass references to resources or modules in a robust way.
This is a very common pattern, typically using the `count` meta-argument to conditionally create resources or modules.

E.g. passing an Azure resource id for a resource so that we can create a child resource.

If we use a string variable to pass the resource id, this value may be unknown at the time of the plan.
Therefore the count expression will be unknown, and the plan will fail.

We should use an object instead, and pass the object's attributes to the child resource.

Example of how to do this in a robust manner:

```terraform
variable "my_resource_id" {
  type = object({
    id = string
  })
  default = null
}

# We can safely evaluate the count expression, because the object is never known after apply.
# The `id` value may be unknown, but the parent object is always knowable.
resource "terraform_data" "my_resource" {
  count = var.my_resource_id != null ? 1 : 0
  input = var.my_resource_id.id
}
```
