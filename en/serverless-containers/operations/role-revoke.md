---
title: "Revoking roles assigned to a container"
description: "Use this guide to revoke roles assigned to a container."
---

# Revoking roles assigned to a container

{% list tabs group=instructions %}

- CLI {#cli}

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

- API {#api}

   To revoke container roles, use the [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/UpdateAccessBindings](../containers/api-ref/grpc/container_service.md#UpdateAccessBindings) gRPC API call.

{% endlist %}