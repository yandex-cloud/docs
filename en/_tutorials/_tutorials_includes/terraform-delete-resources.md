To delete the resources created with {{ TF }}:
1. Run this command:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   {{ TF }} will delete all the resources you created in the current configuration, such as clusters, [networks](../../vpc/concepts/network.md#network), [subnets](../../vpc/concepts/network.md#subnet), and [VMs](../../compute/concepts/vm.md).

   {% endnote %}

   After the command is executed, the terminal will display a list of resources to be deleted.
1. Type `yes` and press **Enter**.