# Assigning roles to a function

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a [role](../../security/index.md#roles) to a function, run the command:

   * User:
      ```
      yc serverless function add-access-binding \
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
      yc serverless function add-access-binding \
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
      yc serverless function add-access-binding \
        --id <function ID> \
        --all-authenticated-users \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```

- API

   You can assign roles to a function using the [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) API method.

{% endlist %}