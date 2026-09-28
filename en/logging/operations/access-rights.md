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

    ```bash
    yc logging group add-access-binding \
      --name <log_group_name> \
      --role <role> \
      --subject <subject_type>:<subject_ID>
    ```

    Where:

    * `--role`: [Role](../security/index.md#roles-list).
    * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

        {% cut "Subject designations" %}

        {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

        {% endcut %}

- API {#api}

  To assign roles for a custom log group, use the [setAccessBindings](../api-ref/LogGroup/setAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/SetAccessBindings](../api-ref/grpc/LogGroup/setAccessBindings.md) gRPC API call.

{% endlist %}

## Revoking roles assigned for a log group {#revoke}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command to revoke a [role](../security/index.md) assigned for a custom log group:

  ```bash
  yc logging group remove-access-binding \
    --name <log_group_name> \
    --role <role_ID> \
    --subject <subject_type>:<subject_ID>
  ```

  Where:

  * `--role`: ID of the role you need to revoke.
  * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) to revoke the role from.

      {% cut "Subject designations" %}

      {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

- API {#api}

  To revoke roles assigned to a custom log group, use the [updateAccessBindings](../api-ref/LogGroup/updateAccessBindings.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/UpdateAccessBindings](../api-ref/grpc/LogGroup/updateAccessBindings.md) gRPC API call. In the request body, set the `action` property to `REMOVE` and specify the [subject](../../iam/concepts/access-control/index.md#subject) type and ID under `subject`.

  {% cut "Subject designations" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
