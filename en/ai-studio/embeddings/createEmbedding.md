---
editable: false
---

# REST: Create embeddings

Creates an embedding vector representing the input text.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/embeddings
```

## Body parameters

**Request schema: application/json**

```json
{
  "input": "unknown",
  "model": "unknown",
  "encoding_format": "string",
  "dimensions": "integer",
  "user": "string"
}
```

#|
||Field | Description ||
|| input | Any of **string** \| **string** ||
|| model | **unknown**

Required field. ID of the model to use. You can use the [List models](https://yandex.cloud/ru/docs/ai-studio/concepts/embeddings#yandexgpt-embeddings) API to see all of your available models. of them. 
 ||
|| encoding_format | **enum**

Required field. The format to return the embeddings in. "base64" currently not supported, "float" required. 


- `float`
- `base64 [NOT SUPPORTED]` ||
|| dimensions | **integer**

NOT SUPPORTED BY ALL MODELS. The number of dimensions the resulting output embeddings should have. 
 ||
|| user | **string**

[CURRENTLY NOT SUPPORTED] ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "data": [
    {
      "index": "integer",
      "embedding": [
        "number"
      ],
      "object": "string"
    }
  ],
  "model": "string",
  "object": "string",
  "usage": {
    "prompt_tokens": "integer",
    "total_tokens": "integer"
  }
}
```

#|
||Field | Description ||
|| data[] | **[Embedding](#Embedding)**

Required field. Represents an embedding vector returned by embedding endpoint. 
 ||
|| model | **string**

Required field. The name of the model used to generate the embedding. ||
|| object | **enum**

Required field. The object type, which is always "list".

- `list` ||
|| usage | **[Usage](#Usage)**

Required field. The usage information for the request. ||
|#

## Embedding {#Embedding}

Represents an embedding vector returned by embedding endpoint. 


#|
||Field | Description ||
|| index | **integer**

Required field. The index of the embedding in the list of embeddings. ||
|| embedding[] | **number** (float)

Required field.  ||
|| object | **enum**

Required field. The object type, which is always "embedding".

- `embedding` ||
|#

## Usage {#Usage}

The usage information for the request.

#|
||Field | Description ||
|| prompt_tokens | **integer**

Required field. The number of tokens used by the prompt. ||
|| total_tokens | **integer**

Required field. The total number of tokens used by the request. ||
|#