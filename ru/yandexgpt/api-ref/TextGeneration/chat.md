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
Describe your chat query: set generation options, context in the instruction part and message history.
 
Field | Description
--- | ---
model | **string**<br><p>Possible value for now: ``general``.</p> <p>The maximum string length in characters is 50.</p> 
generationOptions | **object**<br>Generation options
generationOptions.<br>partialResults | **boolean** (boolean)<br><p>Enables streaming of the partially generated text.</p> 
generationOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of the responses. It is a double number between 0 and infinity. A low temperature causes the responses to be straightforward, a high temperature causes high-level creativity and randomness.</p> 
generationOptions.<br>maxTokens | **integer** (int64)<br><p>Sets response limit in tokens. The total length of [instruction_text], [request_text], and ``maxTokens`` should be equal or less than 7400 tokens.</p> 
messages[] | **object**<br><p>Message history.</p> 
messages[].<br>role | **string**<br><p>Identifies who sent message. For message from the LLM model, the mandatory value is "assistant".</p> 
messages[].<br>text | **string**<br><p>Text of the message.</p> 
instructionText | **string**<br><p>Text of the instruction.</p> 
 
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
Contains a model-generated assistant's response for the chat query.
 
Field | Description
--- | ---
message | **object**<br><p>Assistant's message.</p> <p>Contains description of the message for Chat.</p> 
message.<br>role | **string**<br><p>Identifies who sent message. For message from the LLM model, the mandatory value is "assistant".</p> 
message.<br>text | **string**<br><p>Text of the message.</p> 
numTokens | **string** (int64)<br><p>Total number of tokens for chat request and chat response.</p> 