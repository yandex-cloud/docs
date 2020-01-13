{% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

Read more about Terraform in the [documentation](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

If you created a cluster using Terraform, you can delete it:

1. In the command line, use the `cd <folder path>` command to go to the folder with the Terraform configuration file.

2. Delete resources using the command:

    ```
    terraform destroy
    ```

    {% note alert %}

    Terraform will delete all the resources that you created using it: clusters, networks, subnets, VMs, and so on.

    {% endnote %}

  3. Confirm the deletion of resources.

