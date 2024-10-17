---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Execution/get.md
---

# Workflows Service, gRPC: ExecutionService.Get {#Get}

Retrieves specified Workflow execution.

## gRPC request

**rpc Get ([GetExecutionRequest](#yandex.cloud.serverless.workflows.v1.GetExecutionRequest)) returns ([GetExecutionResponse](#yandex.cloud.serverless.workflows.v1.GetExecutionResponse))**

## GetExecutionRequest {#yandex.cloud.serverless.workflows.v1.GetExecutionRequest}

```json
{
  "executionId": "string"
}
```

#|
||Field | Description ||
|| executionId | **string**

Required field. ID of the Workflow execution. ||
|#

## GetExecutionResponse {#yandex.cloud.serverless.workflows.v1.GetExecutionResponse}

```json
{
  "execution": {
    "id": "string",
    "workflowId": "string",
    "input": {
      // Includes only one of the fields `inputJson`
      "inputJson": "string"
      // end of the list of possible fields
    },
    "result": {
      // Includes only one of the fields `resultJson`
      "resultJson": "string"
      // end of the list of possible fields
    },
    "error": {
      "message": "string",
      "errorCode": "string"
    },
    "status": "Status",
    "startedAt": "google.protobuf.Timestamp",
    "duration": "google.protobuf.Duration"
  }
}
```

#|
||Field | Description ||
|| execution | **[Execution](#yandex.cloud.serverless.workflows.v1.Execution)**

Workflow execution details. ||
|#

## Execution {#yandex.cloud.serverless.workflows.v1.Execution}

#|
||Field | Description ||
|| id | **string**

ID of the Workflow execution. Generated at creation time. ||
|| workflowId | **string**

ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input data for the Workflow execution. ||
|| result | **[ExecutionResult](#yandex.cloud.serverless.workflows.v1.ExecutionResult)**

Result of the Workflow execution. ||
|| error | **[ExecutionError](#yandex.cloud.serverless.workflows.v1.ExecutionError)**

Error details, in case Workflow execution failed. ||
|| status | enum **Status**

Status of the Workflow execution

- `STATUS_UNSPECIFIED`
- `QUEUED`: Workflow execution is being queued.
- `RUNNING`: Workflow execution is running.
- `PAUSED`: Workflow execution is being paused.
- `STOPPED`: Workflow execution is stopped.
- `FAILED`: Workflow execution is failed.
- `FINISHED`: Workflow execution is finished. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the Workflow execution. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Duration of the Workflow execution. ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`. ||
|#

## ExecutionResult {#yandex.cloud.serverless.workflows.v1.ExecutionResult}

#|
||Field | Description ||
|| resultJson | **string**

JSON result of the Workflow execution.

Includes only one of the fields `resultJson`. ||
|#

## ExecutionError {#yandex.cloud.serverless.workflows.v1.ExecutionError}

#|
||Field | Description ||
|| message | **string**

Error message of the Workflow execution. ||
|| errorCode | **string**

Error code of the Workflow execution. ||
|#