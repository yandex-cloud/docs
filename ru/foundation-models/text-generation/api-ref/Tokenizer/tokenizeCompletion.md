---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/Tokenizer/tokenizeCompletion.md
---

# Foundation Models Text Generation API, REST: Tokenizer.TokenizeCompletion {#TokenizeCompletion}

RPC method for tokenizing content of CompletionRequest

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/tokenizeCompletion
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.CompletionRequest}

```json
{
  "modelUri": "string",
  "completionOptions": {
    "stream": "boolean",
    "temperature": "number",
    "maxTokens": "string"
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
|| stream | **boolean**

Enables streaming of partially generated text. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|| maxTokens | **string** (int64)

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

## Response {#yandex.cloud.ai.foundation_models.v1.TokenizeResponse}

**HTTP Code: 200 - OK**

```json
{
  "tokens": [
    {
      "id": "string",
      "text": "string",
      "special": "boolean"
    }
  ],
  "modelVersion": "string"
}
```

Response containing tokenized content from request.

#|
||Field | Description ||
|| tokens[] | **[Token](#yandex.cloud.ai.foundation_models.v1.Token)**

A list of tokens obtained from tokenization. ||
|| modelVersion | **string**

Model version (changes with model releases). ||
|#

## Token {#yandex.cloud.ai.foundation_models.v1.Token}

Represents a token, the basic unit of content, used by the foundation model.

#|
||Field | Description ||
|| id | **string** (int64)

An internal token identifier. ||
|| text | **string**

The textual representation of the token. ||
|| special | **boolean**

Indicates whether the token is special or not. Special tokens may define the model's behavior and are not visible to users. ||
|#