---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/Tokenizer/tokenize.md
---

# Foundation Models Text Generation API, REST: Tokenizer.tokenize
RPC method for tokenizing text.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/tokenize
```
 
## Body parameters {#body_params}
 
```json 
{
  "modelUri": "string",
  "text": "string"
}
```
Request for the service to tokenize input text.
 
Field | Description
--- | ---
modelUri | **string**<br><p>The identifier of the model to be used for tokenization.</p> 
text | **string**<br><p>Text to be tokenized.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "tokens": [
    {
      "id": "string",
      "text": "string",
      "special": true
    }
  ],
  "modelVersion": "string"
}
```
Response containing tokenized content from request.
 
Field | Description
--- | ---
tokens[] | **object**<br><p>A list of tokens obtained from tokenization.</p> 
tokens[].<br>id | **string** (int64)<br><p>An internal token identifier.</p> 
tokens[].<br>text | **string**<br><p>The textual representation of the token.</p> 
tokens[].<br>special | **boolean** (boolean)<br><p>Indicates whether the token is special or not. Special tokens may define the model's behavior and are not visible to users.</p> 
modelVersion | **string**<br><p>Model version (changes with model releases).</p> 