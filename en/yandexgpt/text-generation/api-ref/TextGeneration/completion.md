---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/TextGeneration/completion.md
---

# Foundation Models Text Generation API, REST: TextGeneration.completion
A method for generating text completions in [synchronous mode](/docs/foundation-models/concepts/#working-mode).
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/completion
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
modelUri | **string**<br><p>The <a href="/docs/foundation-models/concepts/yandexgpt/models">ID of the model</a> to be used for completion generation.</p> 
completionOptions | **object**<br><p>Configuration options for completion generation.</p> <p>Defines the options for completion generation.</p> 
completionOptions.<br>stream | **boolean** (boolean)<br><p>Enables streaming of partially generated text.</p> 
completionOptions.<br>temperature | **number** (double)<br><p>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses while higher values lead to increased creativity and randomness. Default temperature: 0.3</p> 
completionOptions.<br>maxTokens | **integer** (int64)<br><p>The limit on the number of tokens used for single completion generation. Must be greater than zero. This maximum allowed parameter value may depend on the model being used.</p> 
messages[] | **object**<br><p>A list of messages representing the context for the completion model.</p> 
messages[].<br>role | **string**<br><p>The ID of the message sender. Supported roles:</p> <ul> <li>``system``: Special role used to define the behaviour of the completion model.</li> <li>``assistant``: A role used by the model to generate responses.</li> <li>``user``: A role used by the user to describe requests to the model.</li> </ul> 
messages[].<br>text | **string**<br><p>Textual content of the message.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "alternatives": [
    {
      "message": {
        "role": "string",
        "text": "string"
      },
      "status": "string"
    }
  ],
  "usage": {
    "inputTextTokens": "string",
    "completionTokens": "string",
    "totalTokens": "string"
  },
  "modelVersion": "string"
}
```
Response containing generated text completions.
 
Field | Description
--- | ---
alternatives[] | **object**<br><p>A list of generated completion alternatives.</p> 
alternatives[].<br>message | **object**<br><p>A message containing the content of the alternative.</p> <p>A message object representing a wrapper over the inputs and outputs of the completion model.</p> 
alternatives[].<br>message.<br>role | **string**<br><p>The ID of the message sender. Supported roles:</p> <ul> <li>``system``: Special role used to define the behaviour of the completion model.</li> <li>``assistant``: A role used by the model to generate responses.</li> <li>``user``: A role used by the user to describe requests to the model.</li> </ul> 
alternatives[].<br>message.<br>text | **string**<br><p>Textual content of the message.</p> 
alternatives[].<br>status | **string**<br><p>The generation status of the alternative</p> <p>Enum representing the generation status of the alternative.</p> <ul> <li>ALTERNATIVE_STATUS_UNSPECIFIED: Unspecified generation status. - ALTERNATIVE_STATUS_PARTIAL: Partially generated alternative.</li> <li>ALTERNATIVE_STATUS_TRUNCATED_FINAL: Incomplete final alternative resulting from reaching the maximum allowed number of tokens.</li> <li>ALTERNATIVE_STATUS_FINAL: Final alternative generated without running into any limits.</li> <li>ALTERNATIVE_STATUS_CONTENT_FILTER: Generation was stopped due to the discovery of potentially sensitive content in the prompt or generated response. To fix, modify the prompt and restart generation.</li> </ul> 
usage | **object**<br><p>A set of statistics describing the number of content tokens used by the completion model.</p> <p>An object representing the number of content <a href="/docs/foundation-models/concepts/yandexgpt/tokens">tokens</a> used by the completion model.</p> 
usage.<br>inputTextTokens | **string** (int64)<br><p>The number of tokens in the textual part of the model input.</p> 
usage.<br>completionTokens | **string** (int64)<br><p>The total number of tokens in the generated completions.</p> 
usage.<br>totalTokens | **string** (int64)<br><p>The total number of tokens, including all input tokens and all generated tokens.</p> 
modelVersion | **string**<br><p>The model version changes with each new releases.</p> 