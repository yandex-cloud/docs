---
editable: false
sourcePath: en/_api-ref-grpc/serverless/workflows/v1/workflows/api-ref/grpc/Execution/get.md
---

# Workflows Service, gRPC: ExecutionService.Get

Retrieves specified Workflow execution.

## gRPC request

**rpc Get ([GetExecutionRequest](#yandex.cloud.serverless.workflows.v1.GetExecutionRequest)) returns ([GetExecutionResponse](#yandex.cloud.serverless.workflows.v1.GetExecutionResponse))**

## GetExecutionRequest {#yandex.cloud.serverless.workflows.v1.GetExecutionRequest}

```json
{
  "execution_id": "string"
}
```

#|
||Field | Description ||
|| execution_id | **string**

Required field. ID of the Workflow execution. ||
|#

## GetExecutionResponse {#yandex.cloud.serverless.workflows.v1.GetExecutionResponse}

```json
{
  "execution": {
    "id": "string",
    "workflow_id": "string",
    "input": {
      // Includes only one of the fields `input_json`
      "input_json": "string"
      // end of the list of possible fields
    },
    "result": {
      // Includes only one of the fields `result_json`
      "result_json": "string"
      // end of the list of possible fields
    },
    "error": {
      "message": "string",
      "error_code": "string"
    },
    "status": "Status",
    "started_at": "google.protobuf.Timestamp",
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
|| workflow_id | **string**

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
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the Workflow execution. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Duration of the Workflow execution. ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| input_json | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `input_json`. ||
|#

## ExecutionResult {#yandex.cloud.serverless.workflows.v1.ExecutionResult}

#|
||Field | Description ||
|| result_json | **string**

JSON result of the Workflow execution.

Includes only one of the fields `result_json`. ||
|#

## ExecutionError {#yandex.cloud.serverless.workflows.v1.ExecutionError}

#|
||Field | Description ||
|| message | **string**

Error message of the Workflow execution. ||
|| error_code | **string**

Error code of the Workflow execution. ||
|#