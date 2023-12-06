---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/TextGeneration/chat.md
---

# YandexGPT API, REST: TextGeneration.chat
RPC method for engaging in a chat conversation with the model.
 

 
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
Request to engage in a chat conversation with a text generation model.
 
Field | Description
--- | ---
model | **string**<br><p>The name or identifier of the model to be used for the chat. Possible value for now: ``general``.</p> <p>The maximum string length in characters is 50.</p> 
generationOptions | **object**<br>Configuration options for text generation.
generationOptions.<br>partialResults | **boolean** (boolean)<br><p>Enables streaming of partially generated text.</p> 
generationOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness.</p> 
generationOptions.<br>maxTokens | **integer** (int64)<br><p>Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response. Must be greater than zero and not exceed 7400 tokens.</p> 
messages[] | **object**<br><p>A list of messages in the conversation.</p> 
messages[].<br>role | **string**<br><p>Identifies the sender of the message.</p> 
messages[].<br>text | **string**<br><p>The text content of the message.</p> 
instructionText | **string**<br><p>The text-based instruction for the conversation.</p> 
 
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
Contains a model-generated response for a chat query.
 
Field | Description
--- | ---
message | **object**<br><p>The assistant's message in the chat conversation.</p> <p>Represents a message within a chat.</p> 
message.<br>role | **string**<br><p>Identifies the sender of the message.</p> 
message.<br>text | **string**<br><p>The text content of the message.</p> 
numTokens | **string** (int64)<br><p>Total number of tokens used in both the chat request and chat response.</p> 