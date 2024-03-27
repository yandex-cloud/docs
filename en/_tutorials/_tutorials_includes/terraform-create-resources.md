1. After checking the configuration, run the command:

   ```bash
   terraform plan
   ```

   The terminal will display a list of resources with parameters. This is a test step; no resources will be created. If the configuration contains any errors, {{ TF }} will point them out.

   {% note alert %}

   You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

   {% endnote %}

1. To create resources, run the command:

   ```bash
   terraform apply
   ```

1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

   {{ TF }} will create all the required resources and the terminal will display the [IP addresses](../../vpc/concepts/address.md) of the created [VMs](../../compute/concepts/vm.md). You can check the new resources and their configuration using the [management console]({{ link-console-main }}).