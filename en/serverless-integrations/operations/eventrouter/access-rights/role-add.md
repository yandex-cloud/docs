---
title: How to assign roles for a {{ er-full-name }} resource
description: Follow this tutorial to assign roles for an {{ er-name }} resource.
---

# Assigning roles for an {{ er-name }} resource

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To assign a role for an {{ er-name }} resource, run the following command:

  * To a user:

      ```bash
      yc serverless <resource_type> add-access-binding <resource_name_or_ID> \
        --user-account-id <user_ID> \
        --role <role>
      ```

  * To a [service account](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless <resource_type> add-access-binding <resource_name_or_ID> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```

  * To all authenticated users (the `All authenticated users` [public group](../../../../iam/concepts/access-control/public-group.md)):

      ```bash
      yc serverless <resource_type> add-access-binding <resource_name_or_ID> \
        --all-authenticated-users \
        --role <role>
      ```

  **Example**

  Assigning a role to a service account for a [bus](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus add-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.eventrouter.auditor
  ```

  Result:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Use the `setAccessBinding` REST API method for the appropriate resource or this gRPC API call: `<service>/SetAccessBinding`.

  For example, when assigning roles for a [bus](../../../concepts/eventrouter/bus.md), use the [setAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/setAccessBindings.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/SetAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/setAccessBindings.md) gRPC API call.

{% endlist %}