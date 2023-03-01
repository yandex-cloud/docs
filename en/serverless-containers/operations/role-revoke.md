# Revoking roles assigned to a container

{% list tabs %}

- CLI

   To revoke a [role](../security/index.md) for a container, run this command:

   * User:
      ```
      yc serverless container remove-access-binding \
        --name <container_name> \
        --user-account-id <user_ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * [Service account](../../iam/concepts/users/service-accounts.md):
      ```
      yc serverless container remove-access-binding \
        --name <container_name> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * All authorized users (`allAuthenticatedUsers` system group):
      ```
      yc serverless container remove-access-binding \
        --name <container_name> \
        --all-authenticated-users \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```

- API

   You can revoke roles assigned to a container using the [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) API method.

{% endlist %}