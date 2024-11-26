---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/TextGeneration/chat.md
---

# YandexGPT API, REST: TextGeneration.Chat

RPC method for engaging in a chat conversation with the model.

## HTTP request

```
POST https://llm.{{ api-host }}/llm/v1alpha/chat
```

## Body parameters {#yandex.cloud.ai.llm.v1alpha.ChatRequest}

```json
{
  "model": "string",
  "generationOptions": {
    "partialResults": "boolean",
    "temperature": "number",
    "maxTokens": "string"
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
|| partialResults | **boolean**

Enables streaming of partially generated text. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. ||
|| maxTokens | **string** (int64)

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

## Response {#yandex.cloud.ai.llm.v1alpha.ChatResponse}

**HTTP Code: 200 - OK**

```json
{
  "message": {
    "role": "string",
    "text": "string"
  },
  "numTokens": "string"
}
```

Contains a model-generated response for a chat query.

#|
||Field | Description ||
|| message | **[Message](#yandex.cloud.ai.llm.v1alpha.Message2)**

The assistant's message in the chat conversation. ||
|| numTokens | **string** (int64)

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