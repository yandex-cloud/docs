---
editable: false
apiPlayground:
  - url: https://llm.{{ api-host }}/foundationModels/v1/completionBatch
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        modelUri:
          description: |-
            **string**
            The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for batch completion generation.
          type: string
        completionOptions:
          description: |-
            **[CompletionOptions](/docs/foundation-models/text-generation/api-ref/TextGeneration/completion#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**
            Configuration options for completion generation.
          $ref: '#/definitions/CompletionOptions'
        sourceDatasetId:
          description: |-
            **string**
            ID of the dataset containing the context for the completion model.
            Includes only one of the fields `sourceDatasetId`.
            Specifies the format of the request.
          type: string
        jsonObject:
          description: |-
            **boolean**
            When set to true, the model will respond with a valid JSON object.
            Be sure to explicitly ask the model for JSON.
            Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.
            Includes only one of the fields `jsonObject`, `jsonSchema`.
            Specifies the format of the model's response.
          type: boolean
        jsonSchema:
          description: |-
            **[JsonSchema](/docs/foundation-models/text-generation/api-ref/TextGeneration/completion#yandex.cloud.ai.foundation_models.v1.JsonSchema)**
            Enforces a specific JSON structure for the model's response based on a provided schema.
            Includes only one of the fields `jsonObject`, `jsonSchema`.
            Specifies the format of the model's response.
          $ref: '#/definitions/JsonSchema'
      additionalProperties: false
    definitions:
      ReasoningOptions:
        type: object
        properties:
          mode:
            description: |-
              **enum** (ReasoningMode)
              Specifies the reasoning mode to be used.
              - `REASONING_MODE_UNSPECIFIED`: Unspecified reasoning mode.
              - `DISABLED`: Disables reasoning. The model will generate a response without performing any internal reasoning.
              - `ENABLED_HIDDEN`: Enables reasoning in a hidden manner without exposing the reasoning steps to the user.
            type: string
            enum:
              - REASONING_MODE_UNSPECIFIED
              - DISABLED
              - ENABLED_HIDDEN
      CompletionOptions:
        type: object
        properties:
          stream:
            description: |-
              **boolean**
              Enables streaming of partially generated text.
            type: boolean
          temperature:
            description: |-
              **number** (double)
              Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
              Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
              Default temperature: 0.3
            type: number
            format: double
          maxTokens:
            description: |-
              **string** (int64)
              The limit on the number of tokens used for single completion generation.
              Must be greater than zero. This maximum allowed parameter value may depend on the model being used.
            type: string
            format: int64
          reasoningOptions:
            description: |-
              **[ReasoningOptions](/docs/foundation-models/text-generation/api-ref/TextGeneration/completion#yandex.cloud.ai.foundation_models.v1.ReasoningOptions)**
              Configures reasoning capabilities for the model, allowing it to perform internal reasoning before responding.
            $ref: '#/definitions/ReasoningOptions'
      JsonSchema:
        type: object
        properties:
          schema:
            description: |-
              **object**
              The JSON Schema that the model's output must conform to.
            type: object
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/TextGenerationBatch/completion.md
---

# Foundation Models Text Generation API, REST: TextGenerationBatch.Completion

A method for generating text completions in [synchronous mode](/docs/foundation-models/concepts/#working-mode).
Note: Not implemented yet

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/completionBatch
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.BatchCompletionRequest}

```json
{
  "modelUri": "string",
  "completionOptions": {
    "stream": "boolean",
    "temperature": "number",
    "maxTokens": "string",
    "reasoningOptions": {
      "mode": "string"
    }
  },
  // Includes only one of the fields `sourceDatasetId`
  "sourceDatasetId": "string",
  // end of the list of possible fields
  // Includes only one of the fields `jsonObject`, `jsonSchema`
  "jsonObject": "boolean",
  "jsonSchema": {
    "schema": "object"
  }
  // end of the list of possible fields
}
```

Request for the service to generate batch text completion.

#|
||Field | Description ||
|| modelUri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for batch completion generation. ||
|| completionOptions | **[CompletionOptions](#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| sourceDatasetId | **string**

ID of the dataset containing the context for the completion model.

Includes only one of the fields `sourceDatasetId`.

Specifies the format of the request. ||
|| jsonObject | **boolean**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `jsonObject`, `jsonSchema`.

Specifies the format of the model's response. ||
|| jsonSchema | **[JsonSchema](#yandex.cloud.ai.foundation_models.v1.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `jsonObject`, `jsonSchema`.

Specifies the format of the model's response. ||
|#

## CompletionOptions {#yandex.cloud.ai.foundation_models.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| stream | **boolean**

Enables streaming of partially generated text. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|| maxTokens | **string** (int64)

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| reasoningOptions | **[ReasoningOptions](#yandex.cloud.ai.foundation_models.v1.ReasoningOptions)**

Configures reasoning capabilities for the model, allowing it to perform internal reasoning before responding. ||
|#

## ReasoningOptions {#yandex.cloud.ai.foundation_models.v1.ReasoningOptions}

Represents reasoning options that enable the model's ability to perform internal reasoning before generating a response.

#|
||Field | Description ||
|| mode | **enum** (ReasoningMode)

Specifies the reasoning mode to be used.

- `REASONING_MODE_UNSPECIFIED`: Unspecified reasoning mode.
- `DISABLED`: Disables reasoning. The model will generate a response without performing any internal reasoning.
- `ENABLED_HIDDEN`: Enables reasoning in a hidden manner without exposing the reasoning steps to the user. ||
|#

## JsonSchema {#yandex.cloud.ai.foundation_models.v1.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **object**

The JSON Schema that the model's output must conform to. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "taskId": "string",
    "taskStatus": "string",
    "completedBatches": "string",
    "totalBatches": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "taskId": "string",
    "taskStatus": "string",
    "resultDatasetId": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[BatchCompletionMetadata](#yandex.cloud.ai.foundation_models.v1.BatchCompletionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| taskId | **string**

The ID of the batch completion task. ||
|| taskStatus | **enum** (BatchInferenceTaskStatus)

The status of the batch completion task.

- `BATCH_INFERENCE_TASK_STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED` ||
|| completedBatches | **string** (int64)

A number of currently completed batches of the completion task. ||
|| totalBatches | **string** (int64)

A number of total batches of the completion task. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## BatchCompletionResponse {#yandex.cloud.ai.foundation_models.v1.BatchCompletionResponse}

Response containing information about completion task.

#|
||Field | Description ||
|| taskId | **string**

The ID of the batch completion task. ||
|| taskStatus | **enum** (BatchInferenceTaskStatus)

The status of the batch completion task.

- `BATCH_INFERENCE_TASK_STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED` ||
|| resultDatasetId | **string**

The ID of the dataset containing completion results. ||
|#