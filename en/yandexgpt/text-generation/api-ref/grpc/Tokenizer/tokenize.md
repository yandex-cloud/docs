---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_generation/text-generation/api-ref/grpc/Tokenizer/tokenize.md
---

# Foundation Models Text Generation API, gRPC: TokenizerService.Tokenize

RPC method for tokenizing text.

## gRPC request

**rpc Tokenize ([TokenizeRequest](#yandex.cloud.ai.foundation_models.v1.TokenizeRequest)) returns ([TokenizeResponse](#yandex.cloud.ai.foundation_models.v1.TokenizeResponse))**

## TokenizeRequest {#yandex.cloud.ai.foundation_models.v1.TokenizeRequest}

```json
{
  "model_uri": "string",
  "text": "string"
}
```

Request for the service to tokenize input text.

#|
||Field | Description ||
|| model_uri | **string**

The identifier of the model to be used for tokenization. ||
|| text | **string**

Text to be tokenized. ||
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
  "model_version": "string"
}
```

Response containing tokenized content from request.

#|
||Field | Description ||
|| tokens[] | **[Token](#yandex.cloud.ai.foundation_models.v1.Token)**

A list of tokens obtained from tokenization. ||
|| model_version | **string**

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