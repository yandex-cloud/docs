---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/Tokenizer/tokenize.md
---

# YandexGPT API, REST: Tokenizer.tokenize
RPC method for tokenizing input text.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/llm/v1alpha/tokenize
```
 
## Body parameters {#body_params}
 
```json 
{
  "model": "string",
  "text": "string"
}
```
Request to tokenize input text.
 
Field | Description
--- | ---
model | **string**<br><p>The name or identifier of the model to be used for tokenization. Possible values for now: ``general``, ``general:embedding``.</p> <p>The maximum string length in characters is 50.</p> 
text | **string**<br><p>The input text to tokenize.</p> 
 
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
  ]
}
```
Tokenization response.
 
Field | Description
--- | ---
tokens[] | **object**<br><p>A list of tokens obtained from tokenization.</p> 
tokens[].<br>id | **string** (int64)<br><p>An internal token identifier.</p> 
tokens[].<br>text | **string**<br><p>The textual representation of the token.</p> 
tokens[].<br>special | **boolean** (boolean)<br><p>Indicates whether the token is special or not. Special tokens define the model's behavior and are not visible to users.</p> 