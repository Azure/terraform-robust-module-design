# Looping for resource blocks

- [back home](../../)

Some Terraform resource schemas define one or more blocks to define the target resource.
A block is a nested configuration structure that is defined within a resource block.
It is identified by the label for the block followed by `{}`.
Note there is no equals sign.

Typically blocks are either singletons (i.e. there is only one block of that type allowed per resource), or they are a list of blocks (i.e. there can be multiple blocks of that type per resource).

```hcl
resource "my_resource" "example" {
  my_block {
    # ...
  }
}
```

## Patterns

- [Dynamic `n` instances](./dynamic_n_instances/)
- [Dynamic zero or one instance](./dynamic_singleton/)
