---
title: How to get a list of workflow executions
description: Follow this guide to view a list of {{ sw-full-name }} workflow executions.
---

# Getting a list of workflow executions

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing the [workflow execution](../../../concepts/workflows/execution.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** and select a workflow.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**. The **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}** page will display a list of workflow executions.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view a list of [workflow executions](../../../concepts/workflows/execution.md):

      ```bash
      yc serverless workflow execution list --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}

- API {#api}

  To view a list of [workflow executions](../../../concepts/workflows/execution.md), use the [list](../../../../serverless-integrations/workflows/api-ref/Execution/list.md) REST API method for the [Execution](../../../../serverless-integrations/workflows/api-ref/Execution/index.md) resource or the [WorkflowsService/List](../../../../serverless-integrations/workflows/api-ref/grpc/Execution/list.md) gRPC API call.

{% endlist %}