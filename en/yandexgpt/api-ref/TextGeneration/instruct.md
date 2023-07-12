---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/TextGeneration/instruct.md
---

# YandexGPT API, REST: TextGeneration.instruct

 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/llm/v1alpha/instruct
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
  "instructionText": "string",
  "requestText": "string"
}
```
Describe your query: set generation options, context in the instruction part and query in the request.
 
Field | Description
--- | ---
model | **string**<br><p>Possible value for now: ``general``.</p> <p>The maximum string length in characters is 50.</p> 
generationOptions | **object**<br>Generation options
generationOptions.<br>partialResults | **boolean** (boolean)<br><p>Enables streaming of the partially generated text.</p> 
generationOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of the responses. It is a double number between 0 and infinity. A low temperature causes the responses to be straightforward, a high temperature causes high-level creativity and randomness.</p> 
generationOptions.<br>maxTokens | **integer** (int64)<br><p>Sets response limit in tokens. It is a int number between 1 and 2000.</p> 
instructionText | **string**<br><p>Text of the instruction. The total length of <a href="/docs/yandexgpt/api-ref/TextGeneration/instruct#body_params">instructionText</a> and <a href="/docs/yandexgpt/api-ref/TextGeneration/instruct#body_params">requestText</a> should be equal or less to 2500 tokens.</p> 
requestText | **string**<br><p>Text of the instruction. The total length of <a href="/docs/yandexgpt/api-ref/TextGeneration/instruct#body_params">instructionText</a> and <a href="/docs/yandexgpt/api-ref/TextGeneration/instruct#body_params">requestText</a> should be equal or less to 2500 tokens.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "alternatives": [
    {
      "text": "string",
      "score": "number",
      "numTokens": "string"
    }
  ],
  "numPromptTokens": "string"
}
```
Contains a set of alternative responses.
 
Field | Description
--- | ---
alternatives[] | **object**<br><p>Generated alternatives</p> 
alternatives[].<br>text | **string**<br><p>Text of the response.</p> 
alternatives[].<br>score | **number** (double)<br><p>Text log likelihood.</p> 
alternatives[].<br>numTokens | **string** (int64)<br><p>Number of tokens in the response.</p> 
numPromptTokens | **string** (int64)<br><p>Number of tokens for instruction text and request text</p> 