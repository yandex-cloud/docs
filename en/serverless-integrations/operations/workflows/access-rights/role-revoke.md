---
title: How to revoke roles assigned for a workflow in {{ sw-full-name }}
description: Follow this guide to revoke roles assigned for a workflow in {{ sw-name }}.
---

# Revoking roles assigned for a workflow

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Run this command to revoke a role for a [workflow](../../../concepts/workflows/workflow.md):

  * From a user:

      ```bash
      yc serverless workflow remove-access-binding <workflow_name_or_ID> \
        --user-account-id <user_ID> \
        --role <role>
      ```

  * From a [service account](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless workflow remove-access-binding <workflow_name_or_ID> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```

  * From all authenticated users (the `All authenticated users` [public group](../../../../iam/concepts/access-control/public-group.md)):

      ```bash
      yc serverless workflow remove-access-binding <workflow_name_or_ID> \
        --all-authenticated-users \
        --role <role>
      ```

  **Example**

  Revoking a role for a workflow from a service account:

  ```bash
  yc serverless workflow remove-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.workflows.auditor
  ```

  Result:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Use the [updateAccessBinding](../../../../serverless-integrations/workflows/api-ref/Workflow/updateAccessBindings.md) REST API method for the [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowService/UpdateAccessBinding](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/updateAccessBindings.md) gRPC API call.

{% endlist %}