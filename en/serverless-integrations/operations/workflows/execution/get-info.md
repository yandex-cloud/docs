---
title: How to get the workflow execution information
description: Follow this guide to view the {{ sw-full-name }} workflow execution information.
---

# Getting the workflow execution information

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing the [workflow execution](../../../concepts/workflows/execution.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** and select a workflow.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**.
  1. Select an execution. The **{{ ui-key.yacloud.common.overview }}** page will display detailed workflow execution information.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view the [workflow execution](../../../concepts/workflows/execution.md) information:

      ```bash
      yc serverless workflow execution get --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Get detailed workflow execution information by specifying the execution ID:

      ```bash
      yc serverless workflow execution get <execution_ID>
      ```

      Result:

      ```text
      execution:
        id: dfq...e78
        workflow_id: dfqud9cbc4k5********
        input:
          input_json: '{}'
        result:
          result_json:
          ...
        status: FINISHED
        started_at: "2025-03-10T15:54:44.304781814Z"
        duration: 1.070697344s
      ```

- API {#api}

  To get the [workflow execution](../../../concepts/workflows/execution.md) information use the [get](../../../../serverless-integrations/workflows/api-ref/Execution/get.md) REST API method for the [Execution](../../../../serverless-integrations/workflows/api-ref/Execution/index.md) resource or the [WorkflowsService/Get](../../../../serverless-integrations/workflows/api-ref/grpc/Execution/get.md) gRPC API call.

{% endlist %}