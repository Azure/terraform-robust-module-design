# Dynamic N instances

This pattern shows how to create N instances of a resource block using a set of objects.
Unlike resources or modules, we do not have to use a map with an arbitrary key.

Do test this pattern does not produce similar results to that of the count index antipattern.
Terraform will remove and re-create all instances of the block if there are any changes, it is down to the provider to handle this properly.
In the case of this example the provider does not re-create all of the subnets.
