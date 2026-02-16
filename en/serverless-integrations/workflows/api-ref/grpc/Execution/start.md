---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Execution/start.md
---

# Workflows Service, gRPC: ExecutionService.Start

Starts new Workflow execution.

## gRPC request

**rpc Start ([StartExecutionRequest](#yandex.cloud.serverless.workflows.v1.StartExecutionRequest)) returns ([StartExecutionResponse](#yandex.cloud.serverless.workflows.v1.StartExecutionResponse))**

## StartExecutionRequest {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest}

```json
{
  "workflow_id": "string",
  "input": {
    // Includes only one of the fields `input_json`
    "input_json": "string"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| workflow_id | **string**

Required field. ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| input_json | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `input_json`. ||
|#

## StartExecutionResponse {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse}

```json
{
  "execution_id": "string"
}
```

#|
||Field | Description ||
|| execution_id | **string**

ID of the Workflow execution. ||
|#