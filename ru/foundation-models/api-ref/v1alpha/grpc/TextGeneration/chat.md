---
editable: false
sourcePath: en/_api-ref-grpc/ai/llm/v1alpha/api-ref/v1alpha/grpc/TextGeneration/chat.md
---

# YandexGPT API, gRPC: TextGenerationService.Chat {#Chat}

RPC method for engaging in a chat conversation with the model.

## gRPC request

**rpc Chat ([ChatRequest](#yandex.cloud.ai.llm.v1alpha.ChatRequest)) returns (stream [ChatResponse](#yandex.cloud.ai.llm.v1alpha.ChatResponse))**

## ChatRequest {#yandex.cloud.ai.llm.v1alpha.ChatRequest}

```json
{
  "model": "string",
  "generationOptions": {
    "partialResults": "bool",
    "temperature": "google.protobuf.DoubleValue",
    "maxTokens": "google.protobuf.Int64Value"
  },
  // Includes only one of the fields `instructionText`
  "instructionText": "string",
  // end of the list of possible fields
  "messages": [
    {
      "role": "string",
      "text": "string"
    }
  ]
}
```

Request to engage in a chat conversation with a text generation model.

#|
||Field | Description ||
|| model | **string**

The name or identifier of the model to be used for the chat.
Possible value for now: `general`. ||
|| generationOptions | **[GenerationOptions](#yandex.cloud.ai.llm.v1alpha.GenerationOptions)**

Configuration options for text generation. ||
|| instructionText | **string**

The text-based instruction for the conversation.

Includes only one of the fields `instructionText`.

Text precondition or context of the request.
For example, the instruction may be "You are a helpful assistant". ||
|| messages[] | **[Message](#yandex.cloud.ai.llm.v1alpha.Message)**

A list of messages in the conversation. ||
|#

## GenerationOptions {#yandex.cloud.ai.llm.v1alpha.GenerationOptions}

Defines the options for text generation.

#|
||Field | Description ||
|| partialResults | **bool**

Enables streaming of partially generated text. ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. ||
|| maxTokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response.
Must be greater than zero and not exceed 7400 tokens. ||
|#

## Message {#yandex.cloud.ai.llm.v1alpha.Message}

Represents a message within a chat.

#|
||Field | Description ||
|| role | **string**

Identifies the sender of the message. ||
|| text | **string**

The text content of the message. ||
|#

## ChatResponse {#yandex.cloud.ai.llm.v1alpha.ChatResponse}

```json
{
  "message": {
    "role": "string",
    "text": "string"
  },
  "numTokens": "int64"
}
```

Contains a model-generated response for a chat query.

#|
||Field | Description ||
|| message | **[Message](#yandex.cloud.ai.llm.v1alpha.Message2)**

The assistant's message in the chat conversation. ||
|| numTokens | **int64**

Total number of tokens used in both the chat request and chat response. ||
|#

## Message {#yandex.cloud.ai.llm.v1alpha.Message2}

Represents a message within a chat.

#|
||Field | Description ||
|| role | **string**

Identifies the sender of the message. ||
|| text | **string**

The text content of the message. ||
|#