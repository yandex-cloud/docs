---
title: Revoking roles assigned for a function
description: Follow this guide to revoke roles assigned for a function.
---

# Revoking roles assigned for a function

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To revoke a [role](../../security/index.md#roles-list) for a function, run this command:

    * From a user:
        ```
        yc serverless function remove-access-binding \
          --id <function_ID> \
          --user-account-id <user_ID> \
          --role <role>
        ```
        Result:
        ```
        done (1s)
        ```
    * From a [service account](../../../iam/concepts/users/service-accounts.md):
        ```
        yc serverless function remove-access-binding \
          --id <function_ID> \
          --service-account-id <service_account_ID> \
          --role <role>
        ```
        Result:
        ```
        done (1s)
        ```
    * From all authenticated users (the `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md)):
        ```
        yc serverless function remove-access-binding \
          --id <function_ID> \
          --all-authenticated-users \
          --role <role>
        ```
        Result:
        ```
        done (1s)
        ```

- API {#api}

  To revoke roles for a function, use the [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/Function/updateAccessBindings.md) gRPC API call.

{% endlist %}