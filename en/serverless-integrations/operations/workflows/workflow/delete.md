---
title: How to delete a workflow
description: Follow this guide to delete a workflow.
---

# Deleting a workflow

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to delete a [workflow](../../../concepts/workflows/workflow.md) in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow delete --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Delete your workflow:

      ```bash
      yc serverless workflow delete <workflow_name_or_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

- API {#api}

  To delete a [workflow](../../../concepts/workflows/workflow.md), use the [Delete](../../../../serverless-integrations/workflows/api-ref/Workflow/delete.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Delete](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/delete.md) gRPC API call.

{% endlist %}