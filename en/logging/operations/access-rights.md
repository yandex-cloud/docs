# Managing rights to access log groups

You can see what roles are [assigned](#list) for a log group, [revoke](#revoke) them, or [assign](#add-access) new roles.

{% note info %}

The [default log group](../concepts/log-group.md) inherits the [roles assigned for the folder](../../iam/operations/roles/get-assigned-roles.md) that it is located in. To update its access rights, [assign](../../iam/operations/roles/grant.md) or [revoke](../../iam/operations/roles/revoke.md) folder roles.

{% endnote %}

## Viewing roles assigned for a log group {#list}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view the [roles](../security/index.md) assigned for a [custom log group](../concepts/log-group.md), run the command:

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

- API

    To view the [roles](../security/index.md#roles) assigned for a [custom log group](../concepts/log-group.md), use the API [listAccessBindings](../api-ref/LogGroup/listAccessBindings.md) method.

{% endlist %}

## Assigning roles for a log group {#add-access}

{% list tabs %}

- CLI

    To assign a [role](../security/index.md) for a custom log group, run the command:

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

- API

    To assign [roles](../security/index.md#roles) for a [custom log group](../concepts/log-group.md), use the API [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md) method.

{% endlist %}

## Revoking roles assigned for a log group {#revoke}

{% list tabs %}

- CLI

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

- API

    To revoke [roles](../security/index.md#roles) assigned for a [custom log group](../concepts/log-group.md), use the API [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md) method.

{% endlist %}

