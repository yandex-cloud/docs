---
title: Revoking roles assigned for a container
description: Follow this guide to revoke roles assigned for a container.
---

# Revoking roles assigned for a container

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command to revoke a [role](../security/index.md) for a container:

    * From a user:
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
    * From a [service account](../../iam/concepts/users/service-accounts.md):
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
    * From all authenticated users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):
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

  To revoke roles for a container, use the [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/UpdateAccessBindings](../containers/api-ref/grpc/Container/updateAccessBindings.md) gRPC API call.

{% endlist %}