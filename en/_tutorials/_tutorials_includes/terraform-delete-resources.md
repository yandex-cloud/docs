To delete the resources created with {{ TF }}:

1. Delete the `resource` and `module` sections from the configuration that belong to this infrastructure, along with the data sources and `output` values that reference them. Save the `terraform` and `provider` sections.

1. Check the deletion plan:

   ```bash
   terraform plan
   ```

   {% note alert %}

   {{ TF }} will delete the resources for which you removed descriptions from the configuration: clusters, [network](../../vpc/concepts/network.md#network), [subnets](../../vpc/concepts/network.md#subnet), [VMs](../../compute/concepts/vm.md), and other entities.

   {% endnote %}

   Check the list of resources that {{ TF }} is going to delete.

1. Apply the changes:

   ```bash
   terraform apply
   ```

1. Confirm the deletion by typing `yes` and pressing **Enter**.
