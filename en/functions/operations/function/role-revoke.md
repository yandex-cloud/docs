---
title: Revoking roles assigned to a function
description: Follow this guide to revoke the roles assigned to a function.
---

# Revoking roles assigned to a function

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To revoke a [role](../../security/index.md#roles-list) for a function, run this command:

    * User:
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
    * [Service account](../../../iam/concepts/users/service-accounts.md):
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
    * All authorized users (the `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md)):
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

  To revoke function roles, use the [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/Function/updateAccessBindings.md) gRPC API call.

{% endlist %}