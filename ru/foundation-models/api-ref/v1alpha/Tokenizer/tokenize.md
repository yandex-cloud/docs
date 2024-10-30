---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/Tokenizer/tokenize.md
---

# YandexGPT API, REST: Tokenizer.Tokenize {#Tokenize}

RPC method for tokenizing input text.

## HTTP request

```
POST https://llm.{{ api-host }}/llm/v1alpha/tokenize
```

## Body parameters {#yandex.cloud.ai.llm.v1alpha.TokenizeRequest}

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

## Response {#yandex.cloud.ai.llm.v1alpha.TokenizeResponse}

**HTTP Code: 200 - OK**

```json
{
  "tokens": [
    {
      "id": "string",
      "text": "string",
      "special": "boolean"
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
|| id | **string** (int64)

An internal token identifier. ||
|| text | **string**

The textual representation of the token. ||
|| special | **boolean**

Indicates whether the token is special or not. Special tokens define the model's behavior and are not visible to users. ||
|#