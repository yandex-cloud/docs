# Viewing roles assigned to a function

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To view [roles](../../security/index.md#roles) assigned to a function, run the command:

   ```
   yc serverless function list-access-bindings <function name>
   ```

   Result:
   ```
   +------------------------------+--------------+-----------------------+
   |           ROLE ID            | SUBJECT TYPE |       SUBJECT ID      |
   +------------------------------+--------------+-----------------------+
   | serverless.functions.invoker | system       | allAuthenticatedUsers |
   +------------------------------+--------------+-----------------------+
   ```

- API

   You can view [roles](../../security/index.md#roles) assigned to a function using the [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md) API method.

{% endlist %}

{% note info %}

[Roles](../../security/index.md#roles) assigned to a folder or cloud are automatically [inherited](../../../iam/concepts/access-control/index.md#inheritance) by the function. However, they don't appear in the list of assigned roles. Learn more about [viewing roles](../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}
