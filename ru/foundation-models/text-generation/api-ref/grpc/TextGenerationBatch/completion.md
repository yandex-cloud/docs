---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_generation/text-generation/api-ref/grpc/TextGenerationBatch/completion.md
---

# Foundation Models Text Generation API, gRPC: TextGenerationBatchService.Completion

A method for generating text completions in [synchronous mode](/docs/foundation-models/concepts/#working-mode).
Note: Not implemented yet

## gRPC request

**rpc Completion ([BatchCompletionRequest](#yandex.cloud.ai.foundation_models.v1.BatchCompletionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## BatchCompletionRequest {#yandex.cloud.ai.foundation_models.v1.BatchCompletionRequest}

```json
{
  "model_uri": "string",
  "completion_options": {
    "stream": "bool",
    "temperature": "google.protobuf.DoubleValue",
    "max_tokens": "google.protobuf.Int64Value",
    "reasoning_options": {
      "mode": "ReasoningMode"
    }
  },
  // Includes only one of the fields `source_dataset_id`
  "source_dataset_id": "string"
  // end of the list of possible fields
}
```

Request for the service to generate batch text completion.

#|
||Field | Description ||
|| model_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for batch completion generation. ||
|| completion_options | **[CompletionOptions](#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| source_dataset_id | **string**

ID of the dataset containing the context for the completion model.

Includes only one of the fields `source_dataset_id`.

Specifies the format of the request. ||
|#

## CompletionOptions {#yandex.cloud.ai.foundation_models.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| stream | **bool**

Enables streaming of partially generated text. ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|| max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| reasoning_options | **[ReasoningOptions](#yandex.cloud.ai.foundation_models.v1.ReasoningOptions)**

Configures reasoning capabilities for the model, allowing it to perform internal reasoning before responding. ||
|#

## ReasoningOptions {#yandex.cloud.ai.foundation_models.v1.ReasoningOptions}

Represents reasoning options that enable the model's ability to perform internal reasoning before generating a response.

#|
||Field | Description ||
|| mode | enum **ReasoningMode**

Specifies the reasoning mode to be used.

- `REASONING_MODE_UNSPECIFIED`: Unspecified reasoning mode.
- `DISABLED`: Disables reasoning. The model will generate a response without performing any internal reasoning.
- `ENABLED_HIDDEN`: Enables reasoning in a hidden manner without exposing the reasoning steps to the user. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "task_id": "string",
    "task_status": "BatchInferenceTaskStatus",
    "completed_batches": "int64",
    "total_batches": "int64"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "task_id": "string",
    "task_status": "BatchInferenceTaskStatus",
    "result_dataset_id": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[BatchCompletionMetadata](#yandex.cloud.ai.foundation_models.v1.BatchCompletionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[BatchCompletionResponse](#yandex.cloud.ai.foundation_models.v1.BatchCompletionResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## BatchCompletionMetadata {#yandex.cloud.ai.foundation_models.v1.BatchCompletionMetadata}

Metadata of the batch completion operation.

#|
||Field | Description ||
|| task_id | **string**

The ID of the batch completion task. ||
|| task_status | enum **BatchInferenceTaskStatus**

The status of the batch completion task.

- `BATCH_INFERENCE_TASK_STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED` ||
|| completed_batches | **int64**

A number of currently completed batches of the completion task. ||
|| total_batches | **int64**

A number of total batches of the completion task. ||
|#

## BatchCompletionResponse {#yandex.cloud.ai.foundation_models.v1.BatchCompletionResponse}

Response containing information about completion task.

#|
||Field | Description ||
|| task_id | **string**

The ID of the batch completion task. ||
|| task_status | enum **BatchInferenceTaskStatus**

The status of the batch completion task.

- `BATCH_INFERENCE_TASK_STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED` ||
|| result_dataset_id | **string**

The ID of the dataset containing completion results. ||
|#