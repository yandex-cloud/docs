---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/Embeddings/embedding.md
---

# YandexGPT API, REST: Embeddings.Embedding

RPC method to obtain embeddings for input text data.

## HTTP request

```
POST https://llm.{{ api-host }}/llm/v1alpha/embedding
```

## Body parameters {#yandex.cloud.ai.llm.v1alpha.EmbeddingRequest}

```json
{
  "embeddingType": "string",
  "model": "string",
  "text": "string"
}
```

Represents a request to obtain embeddings for text data.

#|
||Field | Description ||
|| embeddingType | **enum** (EmbeddingType)

The type of embedding to be generated.

- `EMBEDDING_TYPE_UNSPECIFIED`: Unspecified embedding type.
- `EMBEDDING_TYPE_QUERY`: Embedding for a query. Use this when you have a short query or search term
that you want to obtain an embedding for. Query embeddings are typically
used in information retrieval and search applications.
- `EMBEDDING_TYPE_DOCUMENT`: Embedding for a document. Use this when you have a longer document or a piece
of text that you want to obtain an embedding for. Document embeddings are often
used in natural language understanding and document similarity tasks. ||
|| model | **string**

The name or identifier of the model to be used for embedding. Possible value for now: `general:embedding`. ||
|| text | **string**

The input text for which the embedding is requested. ||
|#

## Response {#yandex.cloud.ai.llm.v1alpha.EmbeddingResponse}

**HTTP Code: 200 - OK**

```json
{
  "embedding": [
    "string"
  ],
  "numTokens": "string"
}
```

Represents a response containing embeddings for input text data.

#|
||Field | Description ||
|| embedding[] | **string**

A repeated list of double values representing the embedding. ||
|| numTokens | **string** (int64)

The number of tokens in the input text. ||
|#