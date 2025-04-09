---
title: How to start a workflow
description: Follow this guide to start a workflow.
---

# Starting a workflow

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to start a [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![GraphNode](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![ellipsis](../../../../_assets/console-icons/ellipsis.svg) next to the workflow in question and select ![TriangleRight](../../../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.serverless-workflows.label_run-workflow }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.start }}** and wait for the workflow to complete.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for starting a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow execution start --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Start a workflow by specifying its name or ID:

      ```bash
      yc serverless workflow execution start <workflow_ID>
      ```

      Result:

      ```text
      execution_id: dfqapb31gq758qil1r8b-b3e3dade-4903-4a6f-9df7-a4b6********
      ```

- API {#api}

  To start a [workflow](../../../concepts/workflows/workflow.md), use the [start](../../../workflows/api-ref/Execution/start.md) REST API method for the [Execution](../../../workflows/api-ref/Execution/index.md) resource or the [ExecutionService/Start](../../../workflows/api-ref/grpc/Execution/start.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../../concepts/workflows/execution.md)
* [{#T}](get-list.md)