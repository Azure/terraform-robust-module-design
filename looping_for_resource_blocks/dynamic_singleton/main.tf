locals {
  thing_enabled = true
}

resource "my_resource" "example" {
  input = "foo"

  # Here we construct a dynamic block where there can be either zero or one instances.
  # We do this by using a `for_each` expression that returns either an empty set or a set with one element.
  # In this scenario it is common to not use the `my_block.value` expression at all, and instead use
  # references to other values.
  dynamic "my_block" {
    for_each = local.lifecycle_enabled ? toset([1]) : toset([])

    content {
      replace_triggered_by = [""]
    }
  }
}
