---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/v1alpha/grpc/EmbeddingsService.md
---

# YandexGPT API, gRPC: EmbeddingsService

Service for obtaining embeddings for text data.

| Call | Description |
| --- | --- |
| [Embedding](#Embedding) | RPC method to obtain embeddings for input text data. |

## Calls EmbeddingsService {#calls}

## Embedding {#Embedding}

RPC method to obtain embeddings for input text data.

**rpc Embedding ([EmbeddingRequest](#EmbeddingRequest)) returns ([EmbeddingResponse](#EmbeddingResponse))**

### EmbeddingRequest {#EmbeddingRequest}

Field | Description
--- | ---
embedding_type | enum **EmbeddingType**<br>The type of embedding to be generated. <ul><li>`EMBEDDING_TYPE_UNSPECIFIED`: Unspecified embedding type.</li><li>`EMBEDDING_TYPE_QUERY`: Embedding for a query. Use this when you have a short query or search term that you want to obtain an embedding for. Query embeddings are typically used in information retrieval and search applications.</li><li>`EMBEDDING_TYPE_DOCUMENT`: Embedding for a document. Use this when you have a longer document or a piece of text that you want to obtain an embedding for. Document embeddings are often used in natural language understanding and document similarity tasks.</li></ul>
model | **string**<br>The name or identifier of the model to be used for embedding. Possible value for now: `general:embedding`. The maximum string length in characters is 50.
text | **string**<br>The input text for which the embedding is requested. 


### EmbeddingResponse {#EmbeddingResponse}

Field | Description
--- | ---
embedding[] | **double**<br>A repeated list of double values representing the embedding. 
num_tokens | **int64**<br>The number of tokens in the input text. 


