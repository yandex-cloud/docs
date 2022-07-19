{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

Read more about {{ TF }} in the [documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

To delete a cluster created using {{ TF }}:

1. In the command line, go to the folder with the current {{ TF }} configuration file with an infrastructure plan.

1. Delete resources using the command:

    ```bash
    terraform destroy
    ```

    {% note alert %}

    {{ TF }} will delete all the resources that you created using it, such as clusters, networks, subnets, and VMs.

    {% endnote %}

1. Confirm the deletion of resources.

