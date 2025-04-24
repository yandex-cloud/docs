---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/embedding/embeddings/api-ref/Embeddings/textEmbedding.md
---

# Foundation Models Embedding API, REST: Embeddings.TextEmbedding

A method for obtaining embeddings from text data.

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/textEmbedding
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.TextEmbeddingRequest}

```json
{
  "modelUri": "string",
  "text": "string",
  "dim": "string"
}
```

Request for the service to obtain text embeddings.

#|
||Field | Description ||
|| modelUri | **string**

The [model URI](/docs/foundation-models/concepts/embeddings) to be used for obtaining text embeddings. ||
|| text | **string**

The input text for which the embedding is requested. ||
|| dim | **string** (int64)

Optional parameter to specify embedding dimension for models that support multi-dimensional outputs ||
|#

## Response {#yandex.cloud.ai.foundation_models.v1.TextEmbeddingResponse}

**HTTP Code: 200 - OK**

```json
{
  "embedding": [
    "string"
  ],
  "numTokens": "string",
  "modelVersion": "string"
}
```

Response containing generated text embedding.

#|
||Field | Description ||
|| embedding[] | **string**

A repeated list of double values representing the embedding. ||
|| numTokens | **string** (int64)

The number of tokens in the input text. ||
|| modelVersion | **string**

The model version changes with each new releases. ||
|#