---
editable: false
sourcePath: en/_api-ref-grpc/ai/llm/v1alpha/api-ref/v1alpha/grpc/Tokenizer/tokenize.md
---

# YandexGPT API, gRPC: TokenizerService.Tokenize {#Tokenize}

RPC method for tokenizing input text.

## gRPC request

**rpc Tokenize ([TokenizeRequest](#yandex.cloud.ai.llm.v1alpha.TokenizeRequest)) returns ([TokenizeResponse](#yandex.cloud.ai.llm.v1alpha.TokenizeResponse))**

## TokenizeRequest {#yandex.cloud.ai.llm.v1alpha.TokenizeRequest}

```json
{
  "model": "string",
  "text": "string"
}
```

Request to tokenize input text.

#|
||Field | Description ||
|| model | **string**

The name or identifier of the model to be used for tokenization.
Possible values for now: `general`, `general:embedding`. ||
|| text | **string**

The input text to tokenize. ||
|#

## TokenizeResponse {#yandex.cloud.ai.llm.v1alpha.TokenizeResponse}

```json
{
  "tokens": [
    {
      "id": "int64",
      "text": "string",
      "special": "bool"
    }
  ]
}
```

Tokenization response.

#|
||Field | Description ||
|| tokens[] | **[Token](#yandex.cloud.ai.llm.v1alpha.Token)**

A list of tokens obtained from tokenization. ||
|#

## Token {#yandex.cloud.ai.llm.v1alpha.Token}

Represents a token, the basic unit of text, used by the LLM.

#|
||Field | Description ||
|| id | **int64**

An internal token identifier. ||
|| text | **string**

The textual representation of the token. ||
|| special | **bool**

Indicates whether the token is special or not. Special tokens define the model's behavior and are not visible to users. ||
|#