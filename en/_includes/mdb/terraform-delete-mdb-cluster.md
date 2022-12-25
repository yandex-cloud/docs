{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

{% if audience != "internal" %}

For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

{% endif %}

To delete a cluster created using {{ TF }}:
1. In the command line, go to the folder with the current {{ TF }} configuration file with an infrastructure plan.
1. Delete resources using the command:

   ```bash
   terraform destroy
   ```

   {% note alert %}

   {{ TF }} will delete all the resources that you created using it, such as clusters, networks, subnets, and VMs.

   {% endnote %}

1. Type the word `yes`, then press **Enter**.