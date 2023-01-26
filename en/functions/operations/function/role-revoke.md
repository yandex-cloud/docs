# Revoking roles assigned to a function

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To revoke a [role](../../security/index.md#roles) for a function, run the command:

   * User:
      ```
      yc serverless function remove-access-binding \
        --id <function ID> \
        --user-account-id <user ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * [Service account](../../../iam/concepts/users/service-accounts.md):
      ```
      yc serverless function remove-access-binding \
        --id <function ID> \
        --service-account-id <service account ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * All authorized users (`allAuthenticatedUsers` system group):
      ```
      yc serverless function remove-access-binding \
        --id <function ID> \
        --all-authenticated-users \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```

- API

   You can revoke roles for a function using the [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) API method.

{% endlist %}