{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}


{% include [terraform-install](../../_includes/terraform-install.md) %}


To delete a cluster created using {{ TF }}:
1. In the command line, go to the folder that houses the current {{ TF }} configuration file with an infrastructure plan.
1. Delete the resources using this command:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   {{ TF }} will delete all the resources you created using it, such as clusters, networks, subnets, and VMs.

   {% endnote %}

1. Type `yes` and press **Enter**.