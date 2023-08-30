---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/Embeddings/embedding.md
---

# YandexGPT API, REST: Embeddings.embedding

 

 
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

 
Field | Description
--- | ---
embeddingType | **string**
model | **string**
text | **string**
 
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

 
Field | Description
--- | ---
embedding[] | **number** (double)
numTokens | **string** (int64)