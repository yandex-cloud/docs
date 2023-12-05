---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/api-ref/Tokenizer/tokenizeCompletion.md
---

# Foundation Models API, REST: Tokenizer.tokenizeCompletion
RPC method for tokenizing content of CompletionRequest
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/tokenizeCompletion
```
 
## Body parameters {#body_params}
 
```json 
{
  "modelUri": "string",
  "completionOptions": {
    "stream": true,
    "temperature": "number",
    "maxTokens": "integer"
  },
  "messages": [
    {
      "role": "string",
      "text": "string"
    }
  ]
}
```
Request for the service to generate text completion.
 
Field | Description
--- | ---
modelUri | **string**<br><p>The identifier of the model to be used for completion generation.</p> 
completionOptions | **object**<br><p>Configuration options for completion generation.</p> <p>Defines the options for completion generation.</p> 
completionOptions.<br>stream | **boolean** (boolean)<br><p>Enables streaming of partially generated text.</p> 
completionOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. Default temperature: 0.6</p> 
completionOptions.<br>maxTokens | **integer** (int64)<br><p>The limit on the number of tokens used for single completion generation. Must be greater than zero. The maximum allowed parameter value may depend on the model used.</p> 
messages[] | **object**<br><p>A list of messages representing the context for the completion model.</p> 
messages[].<br>role | **string**<br><p>Identifier of the message sender. Supported roles: TBD.</p> 
messages[].<br>text | **string**<br><p>Textual content of the message.</p> 
 
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