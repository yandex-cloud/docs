---
title: How to terminate a workflow execution
description: Follow this guide to terminate a workflow execution.
---

# Terminating a workflow execution

If you terminate a [workflow](../../../concepts/workflows/workflow.md) execution, this will interrupt the current active step. To stop a workflow after the current active step is complete, follow [this guide](stop.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where the [workflow execution](./start.md) is in progress.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** and select a workflow.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**.
  1. Next to the execution, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/circle-xmark.svg) **{{ ui-key.yacloud.serverless-workflows.label_terminate-workflow }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for terminating a workflow execution:

      ```bash
      yc serverless workflow execution terminate --help
      ```

  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Terminate the workflow execution:

      ```bash
      yc serverless workflow execution terminate <workflow_execution_ID>
      ```

      Result:

      ```text
      execution_id: dfqmeu8ci1ae2tvocsbv-429e9f6f-b506-4c5a-84b2-9abb********
      ```

- API {#api}

  To terminate a workflow execution, use the [terminate](../../../workflows/api-ref/Execution/terminate.md) REST API method for the [Execution](../../../workflows/api-ref/Execution/index.md) resource or the [ExecutionService/Terminate](../../../workflows/api-ref/grpc/Execution/terminate.md) gRPC API call.

{% endlist %}