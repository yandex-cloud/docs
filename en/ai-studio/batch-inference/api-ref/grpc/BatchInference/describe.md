---
editable: false
sourcePath: en/_api-ref-grpc/ai/batch_inference/v1/batch-inference/api-ref/grpc/BatchInference/describe.md
---

# Batch Inference Service API, gRPC: BatchInferenceService.Describe

Describes a concrete task

## gRPC request

**rpc Describe ([DescribeBatchInferenceRequest](#yandex.cloud.ai.batch_inference.v1.DescribeBatchInferenceRequest)) returns ([DescribeBatchInferenceResponse](#yandex.cloud.ai.batch_inference.v1.DescribeBatchInferenceResponse))**

## DescribeBatchInferenceRequest {#yandex.cloud.ai.batch_inference.v1.DescribeBatchInferenceRequest}

```json
{
  "task_id": "string"
}
```

#|
||Field | Description ||
|| task_id | **string**

Required field. Required task id ||
|#

## DescribeBatchInferenceResponse {#yandex.cloud.ai.batch_inference.v1.DescribeBatchInferenceResponse}

```json
{
  "task": {
    "task_id": "string",
    "operation_id": "string",
    "folder_id": "string",
    "model_uri": "string",
    "source_dataset_id": "string",
    // Includes only one of the fields `completion_request`
    "completion_request": {
      "model_uri": "string",
      "source_dataset_id": "string",
      "completion_options": {
        "temperature": "google.protobuf.DoubleValue",
        "max_tokens": "google.protobuf.Int64Value",
        "reasoning_options": {
          "mode": "ReasoningMode"
        }
      },
      "data_logging_enabled": "bool",
      // Includes only one of the fields `json_object`, `json_schema`
      "json_object": "bool",
      "json_schema": {
        "schema": "google.protobuf.Struct"
      }
      // end of the list of possible fields
    },
    // end of the list of possible fields
    "status": "Status",
    "result_dataset_id": "string",
    "labels": "map<string, string>",
    "created_by": "string",
    "created_at": "google.protobuf.Timestamp",
    "started_at": "google.protobuf.Timestamp",
    "finished_at": "google.protobuf.Timestamp",
    "errors": {
      "status": "google.rpc.Status",
      "line_errors": [
        {
          "line_number": "int64",
          "message": "string"
        }
      ],
      "batch_errors": [
        {
          "batch_number": "int64",
          "first_line": "int64",
          "last_line": "int64",
          "message": "string"
        }
      ]
    }
  }
}
```

#|
||Field | Description ||
|| task | **[BatchInferenceTask](#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask)** ||
|#

## BatchInferenceTask {#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask}

#|
||Field | Description ||
|| task_id | **string** ||
|| operation_id | **string** ||
|| folder_id | **string** ||
|| model_uri | **string** ||
|| source_dataset_id | **string** ||
|| completion_request | **[BatchCompletionRequest](#yandex.cloud.ai.batch_inference.v1.BatchCompletionRequest)**

Includes only one of the fields `completion_request`. ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED` ||
|| result_dataset_id | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| created_by | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| errors | **[ErrorsInfo](#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask.ErrorsInfo)** ||
|#

## BatchCompletionRequest {#yandex.cloud.ai.batch_inference.v1.BatchCompletionRequest}

#|
||Field | Description ||
|| model_uri | **string**

Required field.  ||
|| source_dataset_id | **string**

Required field.  ||
|| completion_options | **[CompletionOptions](#yandex.cloud.ai.batch_inference.v1.CompletionOptions)** ||
|| data_logging_enabled | **bool** ||
|| json_object | **bool**

Includes only one of the fields `json_object`, `json_schema`.

Unsupported ||
|| json_schema | **[JsonSchema](#yandex.cloud.ai.batch_inference.v1.JsonSchema)**

Includes only one of the fields `json_object`, `json_schema`.

Unsupported ||
|#

## CompletionOptions {#yandex.cloud.ai.batch_inference.v1.CompletionOptions}

#|
||Field | Description ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| reasoning_options | **[ReasoningOptions](#yandex.cloud.ai.batch_inference.v1.ReasoningOptions)** ||
|#

## ReasoningOptions {#yandex.cloud.ai.batch_inference.v1.ReasoningOptions}

#|
||Field | Description ||
|| mode | enum **ReasoningMode**

- `REASONING_MODE_UNSPECIFIED`
- `DISABLED`
- `ENABLED_HIDDEN` ||
|#

## JsonSchema {#yandex.cloud.ai.batch_inference.v1.JsonSchema}

#|
||Field | Description ||
|| schema | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)** ||
|#

## ErrorsInfo {#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask.ErrorsInfo}

#|
||Field | Description ||
|| status | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation. ||
|| line_errors[] | **[LineError](#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask.ErrorsInfo.LineError)**

Errors by lines ||
|| batch_errors[] | **[BatchError](#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask.ErrorsInfo.BatchError)**

Errors by batches ||
|#

## LineError {#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask.ErrorsInfo.LineError}

#|
||Field | Description ||
|| line_number | **int64** ||
|| message | **string** ||
|#

## BatchError {#yandex.cloud.ai.batch_inference.v1.BatchInferenceTask.ErrorsInfo.BatchError}

#|
||Field | Description ||
|| batch_number | **int64** ||
|| first_line | **int64**

Range of lines in batch ||
|| last_line | **int64** ||
|| message | **string** ||
|#