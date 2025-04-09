---
title: How to force a workflow to stop
description: Follow this guide to forcibly stop a workflow.
---

# Forcing a workflow to stop

If you force stop a [workflow](../../../concepts/workflows/workflow.md), this will interrupt the current active step. To stop a workflow after the current active step is complete, follow [this guide](stop.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to force stop a workflow:

      ```bash
      yc serverless workflow execution terminate --help
      ```

  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Force a workflow to stop:

      ```bash
      yc serverless workflow execution terminate <workflow_execution_ID>
      ```

      Result:

      ```text
      execution_id: dfqmeu8ci1ae2tvocsbv-429e9f6f-b506-4c5a-84b2-9abb********
      ```

- API {#api}

  To force stop a workflow, use the [terminate](../../../workflows/api-ref/Execution/terminate.md) REST API method for the [Execution](../../../workflows/api-ref/Execution/index.md) resource or the [ExecutionService/Terminate](../../../workflows/api-ref/grpc/Execution/terminate.md) gRPC API call.

{% endlist %}