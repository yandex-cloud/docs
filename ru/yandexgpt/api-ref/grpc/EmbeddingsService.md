---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/grpc/EmbeddingsService.md
---

# Foundation Models API, gRPC: EmbeddingsService

Service for obtaining embeddings from input data.

| Call | Description |
| --- | --- |
| [TextEmbedding](#TextEmbedding) | RPC method for obtaining embeddings from text data. |

## Calls EmbeddingsService {#calls}

## TextEmbedding {#TextEmbedding}

RPC method for obtaining embeddings from text data.

**rpc TextEmbedding ([TextEmbeddingRequest](#TextEmbeddingRequest)) returns ([TextEmbeddingResponse](#TextEmbeddingResponse))**

### TextEmbeddingRequest {#TextEmbeddingRequest}

Field | Description
--- | ---
model_uri | **string**<br>The identifier of the model to be used for obtaining text embeddings. 
text | **string**<br>The input text for which the embedding is requested. 
embedding_type | enum **EmbeddingType**<br>The type of embedding to be generated. <ul><li>`EMBEDDING_TYPE_UNSPECIFIED`: Unspecified embedding type.</li><li>`EMBEDDING_TYPE_QUERY`: Embedding for a query. Use this when you have a short query or search term that you want to obtain an embedding for. Query embeddings are typically used in information retrieval and search applications.</li><li>`EMBEDDING_TYPE_DOCUMENT`: Embedding for a document. Use this when you have a longer document or a piece of text that you want to obtain an embedding for. Document embeddings are often used in natural language understanding and document similarity tasks.</li></ul>


### TextEmbeddingResponse {#TextEmbeddingResponse}

Field | Description
--- | ---
embedding[] | **double**<br>A repeated list of double values representing the embedding. 
num_tokens | **int64**<br>The number of tokens in the input text. 
model_version | **string**<br>Model version (changes with model releases). 


