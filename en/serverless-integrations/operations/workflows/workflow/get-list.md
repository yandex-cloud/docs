---
title: How to get a list of workflows
description: Follow this guide to view a list of available {{ sw-full-name }} workflows.
---

# Getting a list of workflows

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**. The **{{ ui-key.yacloud.serverless-workflows.label_workflows }}** page will display a list of workflows.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view a list of [workflows](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow list --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}

- API {#api}

  To view a list of [workflows](../../../concepts/workflows/workflow.md), use the [list](../../../../serverless-integrations/workflows/api-ref/Workflow/list.md) REST API method for the [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowsService/List](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/list.md) gRPC API call.

{% endlist %}