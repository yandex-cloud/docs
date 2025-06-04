# Managing log group access permissions

You can view the roles [assigned](#list) for a log group, [revoke](#revoke) them, or [assign](#add-access) new ones.

{% note info %}

The [default log group](../concepts/log-group.md) inherits the [roles assigned for the folder](../../iam/operations/roles/get-assigned-roles.md) it resides in. To update the log group access permissions, [assign](../../iam/operations/roles/grant.md) or [revoke](../../iam/operations/roles/revoke.md) the roles for the folder.

{% endnote %}

## Viewing roles assigned for a log group {#list}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view the [roles](../security/index.md) assigned for a [custom log group](../concepts/log-group.md), run this command:

    ```
    yc logging group list-access-bindings --name=<log_group_name>
    ```

    Result:

    ```
    +---------+--------------+-----------------------+
    | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
    +---------+--------------+-----------------------+
    | editor  | system       | allAuthenticatedUsers |
    +---------+--------------+-----------------------+
    ```

- API {#api}

  To view the roles assigned for a custom log group, use the [listAccessBindings](../api-ref/LogGroup/listAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/ListAccessBindings](../api-ref/grpc/LogGroup/listAccessBindings.md) gRPC API call.

{% endlist %}

## Assigning roles for a log group {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

    Run the following command to assign a [role](../security/index.md) for a custom log group:

    * To a user:

        ```
        yc logging group add-access-binding \
          --name <log_group_name> \
          --user-account-id <user_ID> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

    * To a [service account](../../iam/concepts/users/service-accounts.md):

        ```
        yc logging group add-access-binding \
          --name <log_group_name> \
          --service-account-id <service_account_ID> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

    * To all authenticated users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):

        ```
        yc logging group add-access-binding \
          --name <log_group_name> \
          --all-authenticated-users \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

- API {#api}

  To assign roles for a custom log group, use the [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/SetAccessBindings](../api-ref/grpc/LogGroup/setAccessBindings.md) gRPC API call.

{% endlist %}

## Revoking roles assigned for a log group {#revoke}

{% list tabs group=instructions %}

- CLI {#cli}

    Run this command to revoke a [role](../security/index.md) assigned for a custom log group:

    * From a user:

        ```
        yc logging group remove-access-binding \
          --name <log_group_name> \
          --user-account-id <user_ID> \
          --role <role>
        ```
    
        Result:
    
        ```
        done (1s)
        ```

    * From a [service account](../../iam/concepts/users/service-accounts.md):

        ```
        yc logging group remove-access-binding \
          --name <log_group_name> \
          --service-account-id <service_account_ID> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

    * From all authenticated users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):

        ```
        yc logging group remove-access-binding \
          --name <log_group_name> \
          --all-authenticated-users \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

- API {#api}

  To revoke roles assigned to a custom log group, use the [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/UpdateAccessBindings](../api-ref/grpc/LogGroup/updateAccessBindings.md) gRPC API call.

{% endlist %}
