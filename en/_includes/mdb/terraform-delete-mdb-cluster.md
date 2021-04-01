{% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

Read more about Terraform in the [documentation](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

Clusters created using Terraform can be deleted:

  1. In the command line, go to the folder with the Terraform configuration file.
  1. Delete resources using the command:

      ```
      terraform destroy
      ```

      {% note alert %}

      Terraform will delete all the resources that you created using it, such as clusters, networks, subnets, and VMs.

      {% endnote %}

  1. Confirm the deletion of resources.

