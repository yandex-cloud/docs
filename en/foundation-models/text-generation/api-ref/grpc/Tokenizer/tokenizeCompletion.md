---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_generation/text-generation/api-ref/grpc/Tokenizer/tokenizeCompletion.md
---

# Foundation Models Text Generation API, gRPC: TokenizerService.TokenizeCompletion {#TokenizeCompletion}

RPC method for tokenizing content of CompletionRequest

## gRPC request

**rpc TokenizeCompletion ([CompletionRequest](#yandex.cloud.ai.foundation_models.v1.CompletionRequest)) returns ([TokenizeResponse](#yandex.cloud.ai.foundation_models.v1.TokenizeResponse))**

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

## TokenizeResponse {#yandex.cloud.ai.foundation_models.v1.TokenizeResponse}

```json
{
  "tokens": [
    {
      "id": "int64",
      "text": "string",
      "special": "bool"
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
|| id | **int64**

An internal token identifier. ||
|| text | **string**

The textual representation of the token. ||
|| special | **bool**

Indicates whether the token is special or not. Special tokens may define the model's behavior and are not visible to users. ||
|#