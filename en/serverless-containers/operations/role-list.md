# Viewing roles assigned to a container

{% list tabs %}

- CLI

   To view [roles](../security/index.md) assigned to a [container](../concepts/container.md), run this command:

   ```
   yc serverless container list-access-bindings --name=<container_name>
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

   You can view roles assigned to a container using the [listAccessBindings](../../serverless-containers/containers/api-ref/Container/listAccessBindings.md) API method.

{% endlist %}

{% note info %}

[Roles](../security/index.md#roles) assigned to a folder or cloud are automatically inherited by the [container](../../iam/concepts/access-control/index.md#inheritance). However, they do not appear in the list of assigned roles. You can learn more about viewing roles [here](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}
