---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/Embeddings/embedding.md
---

# YandexGPT API, REST: Embeddings.embedding
RPC method to obtain embeddings for input text data.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/llm/v1alpha/embedding
```
 
## Body parameters {#body_params}
 
```json 
{
  "embeddingType": "string",
  "model": "string",
  "text": "string"
}
```
Represents a request to obtain embeddings for text data.
 
Field | Description
--- | ---
embeddingType | **string**<br><p>The type of embedding to be generated.</p> <p>Enum to specify the type of embedding to be generated.</p> <ul> <li>EMBEDDING_TYPE_UNSPECIFIED: Unspecified embedding type. - EMBEDDING_TYPE_QUERY: Embedding for a query. Use this when you have a short query or search term that you want to obtain an embedding for. Query embeddings are typically used in information retrieval and search applications.</li> <li>EMBEDDING_TYPE_DOCUMENT: Embedding for a document. Use this when you have a longer document or a piece of text that you want to obtain an embedding for. Document embeddings are often used in natural language understanding and document similarity tasks.</li> </ul> 
model | **string**<br><p>The name or identifier of the model to be used for embedding. Possible value for now: ``general:embedding``.</p> <p>The maximum string length in characters is 50.</p> 
text | **string**<br><p>The input text for which the embedding is requested.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "embedding": [
    "number"
  ],
  "numTokens": "string"
}
```
Represents a response containing embeddings for input text data.
 
Field | Description
--- | ---
embedding[] | **number** (double)<br><p>A repeated list of double values representing the embedding.</p> 
numTokens | **string** (int64)<br><p>The number of tokens in the input text.</p> 