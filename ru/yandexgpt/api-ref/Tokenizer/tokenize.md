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

 
Field | Description
--- | ---
model | **string**
text | **string**
 
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

 
Field | Description
--- | ---
tokens[] | **object**
tokens[].<br>id | **string** (int64)
tokens[].<br>text | **string**
tokens[].<br>special | **boolean** (boolean)