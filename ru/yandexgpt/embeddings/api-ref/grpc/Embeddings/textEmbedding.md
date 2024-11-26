---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/embedding/embeddings/api-ref/grpc/Embeddings/textEmbedding.md
---

# Foundation Models Embedding API, gRPC: EmbeddingsService.TextEmbedding

A method for obtaining embeddings from text data.

## gRPC request

**rpc TextEmbedding ([TextEmbeddingRequest](#yandex.cloud.ai.foundation_models.v1.TextEmbeddingRequest)) returns ([TextEmbeddingResponse](#yandex.cloud.ai.foundation_models.v1.TextEmbeddingResponse))**

## TextEmbeddingRequest {#yandex.cloud.ai.foundation_models.v1.TextEmbeddingRequest}

```json
{
  "model_uri": "string",
  "text": "string"
}
```

Request for the service to obtain text embeddings.

#|
||Field | Description ||
|| model_uri | **string**

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
  "num_tokens": "int64",
  "model_version": "string"
}
```

Response containing generated text embedding.

#|
||Field | Description ||
|| embedding[] | **double**

A repeated list of double values representing the embedding. ||
|| num_tokens | **int64**

The number of tokens in the input text. ||
|| model_version | **string**

The model version changes with each new releases. ||
|#