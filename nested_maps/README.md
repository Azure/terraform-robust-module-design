# Nested maps

- [back home](../)

In complex modules it is a common pattern to have a map of objects, some of the values of the objects themselves are maps.

For example, your module may create a number of resources, each of which can have a number of sub-resources.
In Azure, a good example of this is resources and role assignments.

## Example Input

```hcl
variable "my_input" {
  type = map(object({
    name = string
    my_nested_map = map(object({
      name = string
    }))
  }))
}
```

## Patterns

- [Flatted nested map](./flatted_nested_map/)
