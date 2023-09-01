---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/Tokenizer/tokenize.md
---

# YandexGPT API, REST: Tokenizer.tokenize

 

 
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
Tokenization request.
 
Field | Description
--- | ---
model | **string**<br><p>Possible value for now: ``general``.</p> <p>The maximum string length in characters is 50.</p> 
text | **string**<br><p>Text for tokenization request.</p> 
 
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
tokens[] | **object**<br><p>Sequence of tokens in tokenized text.</p> 
tokens[].<br>id | **string** (int64)<br><p>Internal token ID.</p> 
tokens[].<br>text | **string**<br><p>Token text representation.</p> 
tokens[].<br>special | **boolean** (boolean)<br><p>Type of token (special or not special). Special tokens define the behaviour of the model and are not visible for users.</p> 