---
title: How to revoke roles assigned for a {{ er-full-name }} resource
description: Follow this guide to revoke roles assigned for an {{ er-name }} resource.
---

# Revoking roles assigned for an {{ er-name }} resource

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Run this command to revoke a role for an {{ er-name }} resource from:

  * User:

      ```bash
      yc serverless <resource_type> remove-access-binding <resource_name_or_ID> \
        --user-account-id <user_ID> \
        --role <role>
      ```

  * [Service account](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless <resource_type> remove-access-binding <resource_name_or_ID> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```

  * All authorized users (the `All authenticated users` [public group](../../../../iam/concepts/access-control/public-group.md)):

      ```bash
      yc serverless <resource_type> remove-access-binding <resource_name_or_ID> \
        --all-authenticated-users \
        --role <role>
      ```

  **Example**

  Revoking a role for a [bus](../../../concepts/eventrouter/bus.md) from a service account:

  ```bash
  yc serverless eventrouter bus remove-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.eventrouter.auditor
  ```

  Result:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Use the `updateAccessBinding` REST API method for the relevant resource or the `<service>/UpdateAccessBinding` gRPC API call.

  For example, for a [bus](../../../concepts/eventrouter/bus.md), use the [updateAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/updateAccessBindings.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [BusService/UpdateAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/updateAccessBindings.md) gRPC API call.

{% endlist %}