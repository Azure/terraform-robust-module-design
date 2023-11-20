# Set of objects antipattern

Do not use a set of objects to create multiple resources or modules which are almost identical.
Use a map with an arbitrary key instead.

The reason is that it is common for module consumers to want to construct inputs to a module using data from other resources.
This will often result in a situation where the keys of the map are not known until apply time, which causes Terraform to fail.

Terraform does not publish this recommendation in public documentation but does provide guidance in the error message:

> ***When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map values.***

## Example

1. Run `terraform init` to initialize the directory.
1. Run `terraform apply` to create the resources.

## Result

Observe the following error:

```text
│ Error: Invalid for_each argument
│
│   on main.tf line 24, in resource "terraform_data" "map_from_set":
│   24:   for_each = { for obj in local.set_of_objects : obj.name => obj }
│     ├────────────────
│     │ local.set_of_objects is set of object with 2 elements
│
│ The "for_each" map includes keys derived from resource attributes that cannot be determined until apply, and so Terraform cannot determine the full set of keys
│ that will identify the instances of this resource.
│
│ When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map
│ values.
│
│ Alternatively, you could use the -target planning option to first apply only the resources that the for_each value depends on, and then apply a second time to
│ fully converge.
```

## Additional nuance

This antipattern does not always become apparent as an issue during module development due to the iterative nature of module development.
To simulate this issue, we can use the following steps:

1. Run `terraform init` to initialize the directory.
1. Run `terraform apply -target='random_pet.name'` to simulate module development by creating the dependent resource first.
1. Run `terraform apply` to give the false impression that the module will deploy without error (we know this to be untrue).

To prevent this, ***Always run `terraform destroy` before running `terraform apply`.*** during module development.
