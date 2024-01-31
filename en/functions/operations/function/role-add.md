---
title: "Assigning roles to a function"
description: "Follow this guide to assign roles to a function."
---

# Assigning roles to a function

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a [role](../../security/index.md#roles-list) to a function, run this command:

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

- API {#api}

   To assign roles for a function, use the [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/function_service.md#SetAccessBindings) gRPC API call.

{% endlist %}