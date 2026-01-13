---
title: How to assign roles for a {{ sw-full-name }} workflow
description: Follow this tutorial to assign roles for a {{ sw-name }} workflow.
---

# Assigning roles for a workflow

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Run the following command to assign a role for a [workflow](../../../concepts/workflows/workflow.md):

  * To a user:

      ```bash
      yc serverless workflow add-access-binding <workflow_name_or_ID> \
        --user-account-id <user_ID> \
        --role <role>
      ```

  * To a [service account](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless workflow add-access-binding <workflow_name_or_ID> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```

  * To all authenticated users (the `All authenticated users` [public group](../../../../iam/concepts/access-control/public-group.md)):

      ```bash
      yc serverless workflow add-access-binding <workflow_name_or_ID> \
        --all-authenticated-users \
        --role <role>
      ```

  **Example**

  Assigning a role for a workflow to a service account:

  ```bash
  yc serverless workflow add-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.workflows.auditor
  ```

  Result:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Use the [setAccessBinding](../../../../serverless-integrations/workflows/api-ref/Workflow/setAccessBindings.md) REST API method for the [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowService/SetAccessBinding](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/setAccessBindings.md) gRPC API call.

{% endlist %}