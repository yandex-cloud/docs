---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/TextGenerationAsync/instruct.md
---

# YandexGPT API, REST: TextGenerationAsync.Instruct

RPC method for instructing the model to generate text.

## HTTP request

```
POST https://llm.{{ api-host }}/llm/v1alpha/instructAsync
```

## Body parameters {#yandex.cloud.ai.llm.v1alpha.InstructRequest}

```json
{
  "model": "string",
  "generationOptions": {
    "partialResults": "boolean",
    "temperature": "number",
    "maxTokens": "string"
  },
  // Includes only one of the fields `instructionText`, `instructionUri`
  "instructionText": "string",
  "instructionUri": "string",
  // end of the list of possible fields
  // Includes only one of the fields `requestText`
  "requestText": "string"
  // end of the list of possible fields
}
```

Request for instructing the model to generate text.

#|
||Field | Description ||
|| model | **string**

The name or identifier of the model to be used for text generation.
Possible value for now: `general`. ||
|| generationOptions | **[GenerationOptions](#yandex.cloud.ai.llm.v1alpha.GenerationOptions)**

Configuration options for text generation. ||
|| instructionText | **string**

The text-based instruction for text generation.

Includes only one of the fields `instructionText`, `instructionUri`.

Text precondition or context of the request.
For example, if the instruction is "You are the youngest Nobel laureate",
the request text might be "Tell us about your daily routine". ||
|| instructionUri | **string**

A URI containing instructions for text generation.

Includes only one of the fields `instructionText`, `instructionUri`.

Text precondition or context of the request.
For example, if the instruction is "You are the youngest Nobel laureate",
the request text might be "Tell us about your daily routine". ||
|| requestText | **string**

The text-based request for text generation.

Includes only one of the fields `requestText`.

Request for text generation. ||
|#

## GenerationOptions {#yandex.cloud.ai.llm.v1alpha.GenerationOptions}

Defines the options for text generation.

#|
||Field | Description ||
|| partialResults | **boolean**

Enables streaming of partially generated text. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. ||
|| maxTokens | **string** (int64)

Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response.
Must be greater than zero and not exceed 7400 tokens. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "alternatives": [
      {
        "text": "string",
        "score": "string",
        "numTokens": "string"
      }
    ],
    "numPromptTokens": "string"
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
|| metadata | **object**

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
|| response | **[InstructResponse](#yandex.cloud.ai.llm.v1alpha.InstructResponse)**

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

## InstructResponse {#yandex.cloud.ai.llm.v1alpha.InstructResponse}

Response containing generated text alternatives and token count.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#yandex.cloud.ai.llm.v1alpha.Alternative)**

A list of alternative text responses. ||
|| numPromptTokens | **string** (int64)

The number of tokens used in the prompt, including both the [instructionText](#yandex.cloud.ai.llm.v1alpha.InstructRequest) and [requestText](#yandex.cloud.ai.llm.v1alpha.InstructRequest). ||
|#

## Alternative {#yandex.cloud.ai.llm.v1alpha.Alternative}

Represents an alternative generated response, including its score and token count.

#|
||Field | Description ||
|| text | **string**

The generated text response. ||
|| score | **string**

The score or confidence of the generated text. ||
|| numTokens | **string** (int64)

The number of tokens in the generated response. ||
|#