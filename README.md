# Robust Terraform module design

This repository shows design patterns that we have found useful when writing Terraform modules.
The patterns are not specific to any particular cloud provider, but the examples are written for Azure.
The patterns are sometimes not the most efficient or beautiful way of doing things, but instead have been created with robustness in mind.

## Content

- [Conditional resource or module instance](./conditional_resource_or_module_instance/)
- [Looping for resources or modules](./looping_for_resources_or_modules/)
- [Looping for resource blocks](./looping_for_resource_blocks/)

## About the authors

These design practices have been developed by the following teams at Microsoft:

- [Azure Landing Zones](https://aka.ms/alz/tf)
- [Azure Verified Modules](https://aka.ms/avm)
- Azure Terraform Engineering
