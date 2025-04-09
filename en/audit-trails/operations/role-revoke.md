---
title: Revoking roles assigned for a trail
description: Use this guide to revoke roles assigned for a trail.
---

# Revoking roles assigned for a trail

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to revoke [roles](../security/index.md#roles-list) assigned for a [trail](../concepts/trail.md):

      ```bash
      yc audit-trails trail remove-access-binding --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. To revoke a role assigned for a trail, run this command:

      * From a user:

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <trail_ID> \
            --user-account-id <user_ID> \
            --role <role>
          ```
          
          Result:

          ```text
          done (1s)
          ```

      * From a [service account](../../iam/concepts/users/service-accounts.md):

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <trail_ID> \
            --service-account-id <service_account_ID> \
            --role <role>
          ```

          Result:

          ```text
          done (1s)
          ```

      * From all authorized users (the `All authenticated users` [public group](../../iam/concepts/access-control/public-group.md)):

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <trail_ID> \
            --all-authenticated-users \
            --role <role>
          ```

          Result:
        
          ```text
          done (1s)
          ```

- API {#api}

  To revoke roles for a [trail](../concepts/trail.md), use the [updateAccessBindings](../../audit-trails/api-ref/Trail/updateAccessBindings.md) REST API method for the [Trail](../../audit-trails/api-ref/Trail/index.md) resource or the [TrailService/UpdateAccessBindings](../../audit-trails/api-ref/grpc/Trail/updateAccessBindings.md) gRPC API call.

{% endlist %}
