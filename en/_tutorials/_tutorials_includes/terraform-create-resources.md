1. After checking the configuration, run the command:

   ```bash
   terraform plan
   ```

   The terminal will display a list of resources and their parameters. No resources are created at this stage. If the configuration contains errors, {{ TF }} will point them out.

   {% note alert %}

   You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

   {% endnote %}

1. To create resources, run the command:

   ```bash
   terraform apply
   ```

1. Confirm creating the resources by typing `yes` and pressing **Enter**.

   {{ TF }} will create the resources and output the [IP addresses](../../vpc/concepts/address.md) of the new [virtual machines](../../compute/concepts/vm.md) in the terminal. Check the resources and their settings in the [management console]({{ link-console-main }}).
