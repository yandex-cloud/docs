---
title: "Revoking roles assigned to a function"
description: "Use this guide to revoke function roles."
---

# Revoking roles assigned to a function

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To revoke a [role](../../security/index.md#roles-list) for a function, run this command:

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
   * All authorized users (`{{ subjects-allAuthenticatedUsers }}` system group):
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

   To revoke function roles, use the [updateAccessBindings](../../functions/api-ref/Function/updateAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/UpdateAccessBindings](../../functions/api-ref/grpc/function_service.md#UpdateAccessBindings) gRPC API call.

{% endlist %}