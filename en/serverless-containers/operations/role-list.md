# Viewing roles assigned to a container

{% note info %}

[Roles](../security/index.md#roles) assigned to a folder or cloud are automatically inherited by the [container](../../iam/concepts/access-control/index.md#inheritance). However, they do not appear in the list of assigned roles. You can learn more about viewing roles [here](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs %}

- CLI

   To view [container](../concepts/container.md) roles, run this command:

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

   To view container roles, use the [listAccessBindings](../containers/api-ref/Container/listAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/ListAccessBindings](../containers/api-ref/grpc/container_service.md#ListAccessBindings) gRPC API call.

{% endlist %}
