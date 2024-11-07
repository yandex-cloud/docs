---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/embedding/embeddings/api-ref/grpc/Embeddings/textEmbedding.md
---

# Foundation Models Embedding API, gRPC: EmbeddingsService.TextEmbedding {#TextEmbedding}

A method for obtaining embeddings from text data.

## gRPC request

**rpc TextEmbedding ([TextEmbeddingRequest](#yandex.cloud.ai.foundation_models.v1.TextEmbeddingRequest)) returns ([TextEmbeddingResponse](#yandex.cloud.ai.foundation_models.v1.TextEmbeddingResponse))**

## TextEmbeddingRequest {#yandex.cloud.ai.foundation_models.v1.TextEmbeddingRequest}

```json
{
  "modelUri": "string",
  "text": "string"
}
```

Request for the service to obtain text embeddings.

#|
||Field | Description ||
|| modelUri | **string**

The [model URI](/docs/foundation-models/concepts/embeddings) to be used for obtaining text embeddings. ||
|| text | **string**

The input text for which the embedding is requested. ||
|#

## TextEmbeddingResponse {#yandex.cloud.ai.foundation_models.v1.TextEmbeddingResponse}

```json
{
  "embedding": [
    "double"
  ],
  "numTokens": "int64",
  "modelVersion": "string"
}
```

Response containing generated text embedding.

#|
||Field | Description ||
|| embedding[] | **double**

A repeated list of double values representing the embedding. ||
|| numTokens | **int64**

The number of tokens in the input text. ||
|| modelVersion | **string**

The model version changes with each new releases. ||
|#