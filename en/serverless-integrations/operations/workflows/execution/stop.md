---
title: How to stop a workflow execution
description: Follow this guide to stop a workflow execution.
---

# Stopping a workflow execution

If you stop a [workflow](../../../concepts/workflows/workflow.md) execution, {{ sw-name }} will first wait for the current active step to complete. Follow this guide to interrupt the step that is currently active: [{#T}](terminate.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where the [workflow execution](./start.md) is in progress.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** and select a workflow.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**.
  1. Next to the execution, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/circle-stop.svg) **{{ ui-key.yacloud.serverless-workflows.label_stop-workflow }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to stop a workflow execution:

      ```bash
      yc serverless workflow execution stop --help
      ```

  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Stop a workflow execution:

      ```bash
      yc serverless workflow execution stop <workflow_execution_ID>
      ```

      Result:

      ```text
      execution_id: dfqmeu8ci1ae2tvocsbv-429e9f6f-b506-4c5a-84b2-9abb********
      ```

- API {#api}

  To stop a workflow execution, use the [stop](../../../workflows/api-ref/Execution/stop.md) REST API method for the [Execution](../../../workflows/api-ref/Execution/index.md) resource or the [ExecutionService/Stop](../../../workflows/api-ref/grpc/Execution/stop.md) gRPC API call.

{% endlist %}