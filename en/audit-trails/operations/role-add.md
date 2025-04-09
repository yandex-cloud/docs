---
title: Assigning roles for a trail
description: Follow this tutorial to assign roles for a trail.
---

# Assigning roles for a trail

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for assigning [roles](../security/index.md#roles-list) for a [trail](../concepts/trail.md):

      ```bash
      yc audit-trails trail set-access-bindings --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. Run the following command to assign a role for a trail:

      * To a user:

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <trail_ID> \
            --access-binding role=<role>,user-account-id=<user_ID>
          ```

          ```text
          done (1s)
          ```

      * To a [service account](../../iam/concepts/users/service-accounts.md):

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <trail_ID> \
            --access-binding role=<role>,service-account-id=<service_account_ID>
          ```

          ```text
          done (1s)
          ```

      * To all authenticated users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <trail_ID> \
            --access-binding role=<role>,all-authenticated-users
          ```

          ```text
          done (1s)
          ```

- API {#api}

  To assign roles for a [trail](../concepts/trail.md), use the [setAccessBindings](../../audit-trails/api-ref/Trail/setAccessBindings.md) REST API method for the [Trail](../../audit-trails/api-ref/Trail/index.md) resource or the [TrailService/SetAccessBindings](../../audit-trails/api-ref/grpc/Trail/setAccessBindings.md) gRPC API call.

{% endlist %}