---
title: Assigning roles to a container
description: Follow this guide to assign roles to a container.
---

# Assigning roles to a container

{% list tabs group=instructions %}

- CLI {#cli}

  To assign a [role](../security/index.md) to a container, run this command:

    * To a user:
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
    * [To a service account](../../iam/concepts/users/service-accounts.md):
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
    * To all authenticated users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):
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

- API {#api}

  To assign roles for a container, use the [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md) gRPC API call.

{% endlist %}