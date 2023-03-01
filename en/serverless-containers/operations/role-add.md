# Assigning roles to a container

{% list tabs %}

- CLI

   To assign a [role](../security/index.md) to a container, run this command:

   * User:
      ```
      yc serverless container add-access-binding \
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
      yc serverless container add-access-binding \
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
      yc serverless container add-access-binding \
        --name <container_name> \
        --all-authenticated-users \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```

- API

   You can assign roles to a container using the [setAccessBindings](../../serverless-containers/containers/api-ref/Container/setAccessBindings.md) API method.

{% endlist %}