# Deleting a function

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Deleting a function

{% list tabs %}

- Management console

    To delete a [function](../../concepts/function.md):
    1. Open the **{{ sf-name }}** section in the folder where you want to delete the function.
    1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the row of the function you want to delete.
    1. In the menu that opens, click **Delete**.
    1. In the window that opens, click **Delete**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Delete the function:

    ```
    $ yc serverless function delete <function name>
    ```

    Result:

    ```
    done (1s)    
    id: b09kk2ujb8js23f73b06
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486t34iut5q
    http_invoke_url: https://functions.yandexcloud.net/b09kk2ujb8js23f73b06
    status: DELETING
    ```

- Terraform

    {% include [terraform-definition](../../../_includes/solutions/terraform-definition.md) %}

    Read more about Terraform in the [documentation](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

    If you created a function using Terraform, you can delete it:

    1. In the command line, go to the directory with the Terraform configuration file.

    2. Delete resources using the command:

       ```
       $ terraform destroy
       ```

       {% note alert %}

       Terraform deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

       {% endnote %}

    3. Confirm the deletion of resources.

{% endlist %}

