# Count index antipattern

Do not use count to create multiple resources or modules which are almost identical.
Use for_each instead.

The reason is that use of count makes it difficult to add or remove resources or modules in the middle of the list.
Typically this will cause Terraform to destroy and recreate resources or modules after the change.

> ***Hint*** Use a map of objects instead

## Example

1. Run `terraform init` to initialize the directory.
1. Run `terraform apply` to create the resources.
1. Observe 4 `terraform_data.arrrgh_dont_do_this` resources are created with indices 0-3.
1. Simulate a change to the deployemnt by commenting out the object with index 1 in `main.tf` - this is clearly marked in the code.
1. Run `terraform plan` and observe that Terraform will unnecessarily re-create resources due to the index changing.

## Result

You should observe the following plan, which needlessly destroys and recreates resources:

```text
Terraform will perform the following actions:

  # terraform_data.arrrgh_dont_do_this[1] must be replaced
-/+ resource "terraform_data" "arrrgh_dont_do_this" {
      ~ id               = "e4b4ea81-6ec8-ed2c-9213-84debd49cf37" -> (known after apply)
      ~ input            = {
          ~ attr  = "bar2" -> "baz2"
          ~ name  = "corgi-bar" -> "corgi-baz"
            # (1 unchanged attribute hidden)
        }
      ~ output           = {
          - attr  = "bar2"
          - attr2 = "data2"
          - name  = "corgi-bar"
        } -> (known after apply)
      ~ triggers_replace = "corgi-bar" -> "corgi-baz"
    }

  # terraform_data.arrrgh_dont_do_this[2] must be replaced
-/+ resource "terraform_data" "arrrgh_dont_do_this" {
      ~ id               = "0277f94a-12df-8394-f62f-4267edea1552" -> (known after apply)
      ~ input            = {
          ~ attr  = "baz2" -> "fiz2"
          ~ name  = "corgi-baz" -> "corgi-fiz"
            # (1 unchanged attribute hidden)
        }
      ~ output           = {
          - attr  = "baz2"
          - attr2 = "data3"
          - name  = "corgi-baz"
        } -> (known after apply)
      ~ triggers_replace = "corgi-baz" -> "corgi-fiz"
    }

  # terraform_data.arrrgh_dont_do_this[3] will be destroyed
  # (because index [3] is out of range for count)
  - resource "terraform_data" "arrrgh_dont_do_this" {
      - id               = "44f5f320-3c06-0b65-56fb-789815158cc1" -> null
      - input            = {
          - attr  = "fiz2"
          - attr2 = "data4"
          - name  = "corgi-fiz"
        } -> null
      - output           = {
          - attr  = "fiz2"
          - attr2 = "data4"
          - name  = "corgi-fiz"
        } -> null
      - triggers_replace = "corgi-fiz" -> null
    }

Plan: 2 to add, 0 to change, 3 to destroy.
```
