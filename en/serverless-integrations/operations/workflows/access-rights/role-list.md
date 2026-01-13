---
title: How to view roles assigned for a workflow in {{ sw-full-name }}
description: Follow this guide to view roles assigned for {{ sw-name }}.
---

# Viewing roles assigned for a workflow

{% note info %}

{{ sw-name }} automatically [inherit](../../../../iam/concepts/access-control/index.md#inheritance) roles assigned for the relevant folder, cloud, or organization. However, they are not displayed in the list of assigned roles. You can learn more about viewing roles [here](../../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To view roles assigned for a [workflow](../../../concepts/workflows/workflow.md), run this command:

  ```bash
  yc serverless workflow list-access-bindings <workflow_name_or_ID>
  ```

  Result:

  ```text
  +---------------------------------+----------------+----------------------+
  |             ROLE ID             |  SUBJECT TYPE  |      SUBJECT ID      |
  +---------------------------------+----------------+----------------------+
  | serverless.workflows.admin      | serviceAccount | ajef2lm8ahpc******** |
  | serverless.workflows.viewer     | serviceAccount | rrbilgiqaptv******** |
  | serverless.workflows.executor   | userAccount    | aje9o8d241nl******** |
  +---------------------------------+----------------+----------------------+
  ```

- API {#api}

  Use the [listAccessBindings](../../../../serverless-integrations/workflows/api-ref/Workflow/listAccessBindings.md) REST API method for the [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowService/ListAccessBindings](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/listAccessBindings.md) gRPC API call.

{% endlist %}