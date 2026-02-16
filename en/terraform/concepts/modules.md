# Modules

**Modules in {{ TF }}** are a code organization tool that allows you to break down a larger infrastructure into smaller, manageable parts.

A module is a separate file with code describing a specific part of your infrastructure. It may contain [resources](resources.md), variables, input parameters, and other elements you need to create and manage infrastructure.

{{ TF }} modules offer multiple benefits:

* Code reuse. You can use modules across different projects, which eliminates code duplication and streamlines development.
* Code organization. Splitting infrastructure into modules improves code organization and readability.
* Testing. You can test each module independently, which simplifies debugging and improves infrastructure reliability.

To create a module, follow these steps:

1. Create a new `.tf` or `.tf.json` file.
1. Define input parameters for calling the module.
1. Describe resources and configurations the module should create.
1. Call the module from the main configuration file using the `module` command.

Module use case:

```
module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
}
```

In this example, we call the `vpc` module located in the `./modules/vpc` file. The module accepts the `cidr_block` input parameter defining the IP address range for the cloud network.

## See also {#see-also}

![](../../_assets/overview/solution-library-icon.svg) [{{ yandex-cloud }} {{ TF }} modules](https://github.com/terraform-yc-modules)