---
editable: false
apiPlayground:
  - url: https://llm.{{ api-host }}/foundationModels/v1/tokenize
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        modelUri:
          description: |-
            **string**
            The identifier of the model to be used for tokenization.
          type: string
        text:
          description: |-
            **string**
            Text to be tokenized.
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/Tokenizer/tokenize.md
---

# Foundation Models Text Generation API, REST: Tokenizer.Tokenize

RPC method for tokenizing text.

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/tokenize
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.TokenizeRequest}

```json
{
  "modelUri": "string",
  "text": "string"
}
```

Request for the service to tokenize input text.

#|
||Field | Description ||
|| modelUri | **string**

The identifier of the model to be used for tokenization. ||
|| text | **string**

Text to be tokenized. ||
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