# Looping for resources or modules

- [back home](../../)

It is extremely common to want to create zero to many resources or modules, based on a variable.
The only robust pattern for doing this is to use a map of objects, with an arbitrary key.

Terraform also thinks this is the case, but hides the guidance in an error message for some reason:

***When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map values.***

## Patterns

- [Map of objects](./map_of_objects/)

## Antipatterns

- [Set of objects antipattern](./set_of_objects_antipattern/)
- [Count index antipattern](./count_index_antipattern/)
