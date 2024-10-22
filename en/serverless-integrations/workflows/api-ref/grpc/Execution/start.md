---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Execution/start.md
---

# Workflows Service, gRPC: ExecutionService.Start {#Start}

Starts new Workflow execution.

## gRPC request

**rpc Start ([StartExecutionRequest](#yandex.cloud.serverless.workflows.v1.StartExecutionRequest)) returns ([StartExecutionResponse](#yandex.cloud.serverless.workflows.v1.StartExecutionResponse))**

## StartExecutionRequest {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest}

```json
{
  "workflowId": "string",
  "input": {
    // Includes only one of the fields `inputJson`
    "inputJson": "string"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`. ||
|#

## StartExecutionResponse {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse}

```json
{
  "executionId": "string"
}
```

#|
||Field | Description ||
|| executionId | **string**

ID of the Workflow execution. ||
|#