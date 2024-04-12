---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/embedding/embeddings/api-ref/Embeddings/textEmbedding.md
---

# Foundation Models Embedding API, REST: Embeddings.textEmbedding
A method for obtaining embeddings from text data.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/textEmbedding
```
 
## Body parameters {#body_params}
 
```json 
{
  "modelUri": "string",
  "text": "string"
}
```
Request for the service to obtain text embeddings.
 
Field | Description
--- | ---
modelUri | **string**<br><p>The <a href="/docs/foundation-models/concepts/embeddings">ID of the model</a> to be used for obtaining text embeddings.</p> 
text | **string**<br><p>The input text for which the embedding is requested.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "embedding": [
    "number"
  ],
  "numTokens": "string",
  "modelVersion": "string"
}
```
Response containing generated text embedding.
 
Field | Description
--- | ---
embedding[] | **number** (double)<br><p>A repeated list of double values representing the embedding.</p> 
numTokens | **string** (int64)<br><p>The number of tokens in the input text.</p> 
modelVersion | **string**<br><p>The model version changes with each new releases.</p> 