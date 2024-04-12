---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/embeddings/embeddings/api-ref/grpc/embedding_service.md
---

# Foundation Models Embedding API, gRPC: EmbeddingsService

Service for obtaining embeddings from input data.

| Call | Description |
| --- | --- |
| [TextEmbedding](#TextEmbedding) | A method for obtaining embeddings from text data. |

## Calls EmbeddingsService {#calls}

## TextEmbedding {#TextEmbedding}

A method for obtaining embeddings from text data.

**rpc TextEmbedding ([TextEmbeddingRequest](#TextEmbeddingRequest)) returns ([TextEmbeddingResponse](#TextEmbeddingResponse))**

### TextEmbeddingRequest {#TextEmbeddingRequest}

Field | Description
--- | ---
model_uri | **string**<br>The [ID of the model](/docs/foundation-models/concepts/embeddings) to be used for obtaining text embeddings. 
text | **string**<br>The input text for which the embedding is requested. 


### TextEmbeddingResponse {#TextEmbeddingResponse}

Field | Description
--- | ---
embedding[] | **double**<br>A repeated list of double values representing the embedding. 
num_tokens | **int64**<br>The number of tokens in the input text. 
model_version | **string**<br>The model version changes with each new releases. 


