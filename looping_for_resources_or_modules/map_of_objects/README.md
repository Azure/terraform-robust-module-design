# Map of objects

- [back to parent](../)
- [back home](../../)

Using a map of objects, with a arbitrary key is the most robust way of looping for resources or modules.

Terraform also thinks this is the case, but hides the guidance in an error message for some reason:

***When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map values.***
