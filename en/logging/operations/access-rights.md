# Managing rights to access log groups

You can see what roles are [assigned](#list) for a log group, [revoke](#revoke) them, or [assign](#add-access) new roles.

{% note info %}

The [default log group](../concepts/log-group.md) inherits the [roles assigned for the folder](../../iam/operations/roles/get-assigned-roles.md) that it is located in. To update its access rights, [assign](../../iam/operations/roles/grant.md) or [revoke](../../iam/operations/roles/revoke.md) folder roles.

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

  To view the roles assigned for a custom log group, use the [listAccessBindings](../api-ref/LogGroup/listAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/ListAccessBindings](../api-ref/grpc/log_group_service.md#ListAccessBindings) gRPC API call.

{% endlist %}

## Assigning roles for a log group {#add-access}

{% list tabs group=instructions %}

- CLI {#cli}

    To assign a [role](../security/index.md) to a custom log group, run this command:

    * User:

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

    * [Service account](../../iam/concepts/users/service-accounts.md):

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

    * All authorized users (`allAuthenticatedUsers` system group):

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

  To assign roles for a custom log group, use the [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/SetAccessBindings](../api-ref/grpc/log_group_service.md#SetAccessBindings) gRPC API call.

{% endlist %}

## Revoking roles assigned for a log group {#revoke}

{% list tabs group=instructions %}

- CLI {#cli}

    To revoke a [role](../security/index.md) assigned for a custom log group, run the command:

    * User:

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

    * [Service account](../../iam/concepts/users/service-accounts.md):

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

    * All authorized users (`allAuthenticatedUsers` system group):

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

  To revoke roles assigned to a custom log group, use the [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/UpdateAccessBindings](../api-ref/grpc/log_group_service.md#UpdateAccessBindings) gRPC API call.

{% endlist %}
