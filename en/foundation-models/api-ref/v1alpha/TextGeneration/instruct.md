---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/TextGeneration/instruct.md
---

# YandexGPT API, REST: TextGeneration.instruct
RPC method for instructing the model to generate text.
 

 
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

  //  includes only one of the fields `instructionText`, `instructionUri`
  "instructionText": "string",
  "instructionUri": "string",
  // end of the list of possible fields

  "requestText": "string"
}
```
Request for instructing the model to generate text.
 
Field | Description
--- | ---
model | **string**<br><p>The name or identifier of the model to be used for text generation. Possible value for now: ``general``.</p> <p>The maximum string length in characters is 50.</p> 
generationOptions | **object**<br>Configuration options for text generation.
generationOptions.<br>partialResults | **boolean** (boolean)<br><p>Enables streaming of partially generated text.</p> 
generationOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness.</p> 
generationOptions.<br>maxTokens | **integer** (int64)<br><p>Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response. Must be greater than zero and not exceed 7400 tokens.</p> 
instructionText | **string** <br> includes only one of the fields `instructionText`, `instructionUri`<br><br><p>The text-based instruction for text generation.</p> 
instructionUri | **string** <br> includes only one of the fields `instructionText`, `instructionUri`<br><br><p>A URI containing instructions for text generation.</p> 
requestText | **string**<br><p>The text-based request for text generation.</p> 
 
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
Response containing generated text alternatives and token count.
 
Field | Description
--- | ---
alternatives[] | **object**<br><p>A list of alternative text responses.</p> 
alternatives[].<br>text | **string**<br><p>The generated text response.</p> 
alternatives[].<br>score | **number** (double)<br><p>The score or confidence of the generated text.</p> 
alternatives[].<br>numTokens | **string** (int64)<br><p>The number of tokens in the generated response.</p> 
numPromptTokens | **string** (int64)<br><p>The number of tokens used in the prompt, including both the [instruction_text] and [request_text].</p> 