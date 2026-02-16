---
title: How to get detailed information on the progress of each workflow step
description: Follow this guide to view detailed information on the progress of each {{ sw-full-name }} workflow step.
---

# Getting detailed information on the progress of each workflow step

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing the [workflow execution](../../../concepts/workflows/execution.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** and select a workflow.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}** and select an execution.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/timeline.svg) **{{ ui-key.yacloud.serverless-workflows.label_timeline }}**. The **{{ ui-key.yacloud.serverless-workflows.label_timeline }}** page will display the chart of the workflow execution steps.
  1. Click the bar of the step of your choice. The **{{ ui-key.yacloud.common.overview }}**, **{{ ui-key.yacloud.serverless-workflows.label_input-data }}**, and **{{ ui-key.yacloud.serverless-workflows.label_output-data }}** tabs at the bottom of the screen will display detailed information about the step progress.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view the [workflow execution](../../../concepts/workflows/execution.md) information:

      ```bash
      yc serverless workflow execution get-history --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. To get detailed information on the progress of each workflow execution step, specify the execution ID:

      ```bash
      yc serverless workflow execution get-history <execution_ID>
      ```

      Result:

      ```text
      id: dfq...e78
      workflow_id: dfqud9cbc4k5********
      status: FINISHED
      started_at: "2025-03-10T15:54:44.304781814Z"
      duration: 1.070697344s
      entries:
        - id: fetch_posts
          started_at: "2025-03-10T15:54:44.452347159Z"
          duration: 0.795435385s
          input:
            input_json: '{"input":{}}'
          output:
            output_json:
            ...
          status: COMPLETED
          type: HttpCall
          attempts: "1"
        ...
        - id: fetch_users
          started_at: "2025-03-10T15:54:44.452394388Z"
          duration: 0.751175310s
          input:
            input_json: '{"input":{}}'
          output:
            output_json:
            ...
          status: COMPLETED
          type: HttpCall
          attempts: "1"
      ```

- API {#api}

  To get detailed information on the progress of each [workflow execution](../../../concepts/workflows/execution.md) step, use the [getHistory](../../../../serverless-integrations/workflows/api-ref/Execution/getHistory.md) REST API method for the [Execution](../../../../serverless-integrations/workflows/api-ref/Execution/index.md) resource or the [WorkflowsService/GetHistory](../../../../serverless-integrations/workflows/api-ref/grpc/Execution/getHistory.md) gRPC API call.

{% endlist %}