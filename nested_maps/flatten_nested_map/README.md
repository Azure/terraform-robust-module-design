# Nested maps

- [back home](../../)
- [back to parent](../)

In complex modules it is a common pattern to have a map of objects, some of the values of the objects themselves are maps.

## Example Input

```hcl
variable "my_input" {
  type = map(object({
    name          = string
    my_nested_map = map(object({
      name = string
    }))
  }))
  default = {}
}
```

## Patterns

- [Flatted nested map](./flatted_nested_map/)
