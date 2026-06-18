# Making a function private

For a function to be invoked only by users with the permission to do so, make the function private.

{% note info %}

If all unauthorized users (the `All users` [public group](../../../iam/concepts/access-control/public-group.md)) of a cloud or folder are granted permissions to invoke a function, the function will be public regardless of its settings. For information on how to revoke a role, see [this guide](../../../iam/operations/roles/revoke.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function you want to make private.
    1. On the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page, disable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
    
- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To make a function private, run this command:

    ```bash
    yc serverless function deny-unauthenticated-invoke <function_name>
    ```

    Result:
    ```text
    done (1s)   
    ```

{% endlist %}
