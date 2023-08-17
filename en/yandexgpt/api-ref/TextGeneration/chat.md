---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/TextGeneration/chat.md
---

# YandexGPT API, REST: TextGeneration.chat

 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/llm/v1alpha/chat
```
 
## Body parameters {#body_params}
 
```json 
{
  "model": "string",
  "generationOptions": {
    "partialResults": true,
    "temperature": "number",
    "maxTokens": "integer"
  },
  "messages": [
    {
      "role": "string",
      "text": "string"
    }
  ],
  "instructionText": "string"
}
```

 
Field | Description
--- | ---
model | **string**
generationOptions | **object**<br><p>Sets the generation options.</p> 
generationOptions.<br>partialResults | **boolean** (boolean)<br><p>Enables streaming of the partially generated text.</p> 
generationOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of the responses. It is a double number between 0 and infinity. A low temperature causes the responses to be straightforward, a high temperature causes high-level creativity and randomness.</p> 
generationOptions.<br>maxTokens | **integer** (int64)<br><p>Sets response limit in tokens. It is a int number between 1 and 2000.</p> 
messages[] | **object**
messages[].<br>role | **string**
messages[].<br>text | **string**
instructionText | **string**
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "message": {
    "role": "string",
    "text": "string"
  },
  "numTokens": "string"
}
```

 
Field | Description
--- | ---
message | **object**
message.<br>role | **string**
message.<br>text | **string**
numTokens | **string** (int64)