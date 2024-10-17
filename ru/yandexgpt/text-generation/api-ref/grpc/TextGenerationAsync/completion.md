---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_generation/text-generation/api-ref/grpc/TextGenerationAsync/completion.md
---

# Foundation Models Text Generation API, gRPC: TextGenerationAsyncService.Completion {#Completion}

A method for generating text completions in [asynchronous mode](/docs/foundation-models/concepts/#working-mode).

## gRPC request

**rpc Completion ([CompletionRequest](#yandex.cloud.ai.foundation_models.v1.CompletionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CompletionRequest {#yandex.cloud.ai.foundation_models.v1.CompletionRequest}

```json
{
  "modelUri": "string",
  "completionOptions": {
    "stream": "bool",
    "temperature": "google.protobuf.DoubleValue",
    "maxTokens": "google.protobuf.Int64Value"
  },
  "messages": [
    {
      "role": "string",
      // Includes only one of the fields `text`
      "text": "string"
      // end of the list of possible fields
    }
  ]
}
```

Request for the service to generate text completion.

#|
||Field | Description ||
|| modelUri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| completionOptions | **[CompletionOptions](#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| messages[] | **[Message](#yandex.cloud.ai.foundation_models.v1.Message)**

A list of messages representing the context for the completion model. ||
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
|| maxTokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|#

## Message {#yandex.cloud.ai.foundation_models.v1.Message}

A message object representing a wrapper over the inputs and outputs of the completion model.

#|
||Field | Description ||
|| role | **string**

The ID of the message sender. Supported roles:
* `system`: Special role used to define the behaviour of the completion model.
* `assistant`: A role used by the model to generate responses.
* `user`: A role used by the user to describe requests to the model. ||
|| text | **string**

Textual content of the message.

Includes only one of the fields `text`.

Message content. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "alternatives": [
      {
        "message": {
          "role": "string",
          // Includes only one of the fields `text`
          "text": "string"
          // end of the list of possible fields
        },
        "status": "AlternativeStatus"
      }
    ],
    "usage": {
      "inputTextTokens": "int64",
      "completionTokens": "int64",
      "totalTokens": "int64"
    },
    "modelVersion": "string"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[CompletionResponse](#yandex.cloud.ai.foundation_models.v1.CompletionResponse)**

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

## CompletionResponse {#yandex.cloud.ai.foundation_models.v1.CompletionResponse}

Response containing generated text completions.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#yandex.cloud.ai.foundation_models.v1.Alternative)**

A list of generated completion alternatives. ||
|| usage | **[ContentUsage](#yandex.cloud.ai.foundation_models.v1.ContentUsage)**

A set of statistics describing the number of content tokens used by the completion model. ||
|| modelVersion | **string**

The model version changes with each new releases. ||
|#

## Alternative {#yandex.cloud.ai.foundation_models.v1.Alternative}

Represents a generated completion alternative, including its content and generation status.

#|
||Field | Description ||
|| message | **[Message](#yandex.cloud.ai.foundation_models.v1.Message2)**

A message containing the content of the alternative. ||
|| status | enum **AlternativeStatus**

The generation status of the alternative

- `ALTERNATIVE_STATUS_UNSPECIFIED`: Unspecified generation status.
- `ALTERNATIVE_STATUS_PARTIAL`: Partially generated alternative.
- `ALTERNATIVE_STATUS_TRUNCATED_FINAL`: Incomplete final alternative resulting from reaching the maximum allowed number of tokens.
- `ALTERNATIVE_STATUS_FINAL`: Final alternative generated without running into any limits.
- `ALTERNATIVE_STATUS_CONTENT_FILTER`: Generation was stopped due to the discovery of potentially sensitive content in the prompt or generated response.
To fix, modify the prompt and restart generation. ||
|#

## Message {#yandex.cloud.ai.foundation_models.v1.Message2}

A message object representing a wrapper over the inputs and outputs of the completion model.

#|
||Field | Description ||
|| role | **string**

The ID of the message sender. Supported roles:
* `system`: Special role used to define the behaviour of the completion model.
* `assistant`: A role used by the model to generate responses.
* `user`: A role used by the user to describe requests to the model. ||
|| text | **string**

Textual content of the message.

Includes only one of the fields `text`.

Message content. ||
|#

## ContentUsage {#yandex.cloud.ai.foundation_models.v1.ContentUsage}

An object representing the number of content [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model.

#|
||Field | Description ||
|| inputTextTokens | **int64**

The number of tokens in the textual part of the model input. ||
|| completionTokens | **int64**

The total number of tokens in the generated completions. ||
|| totalTokens | **int64**

The total number of tokens, including all input tokens and all generated tokens. ||
|#