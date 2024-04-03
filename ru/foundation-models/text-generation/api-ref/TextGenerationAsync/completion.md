---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/TextGenerationAsync/completion.md
---

# Foundation Models Text Generation API, REST: TextGenerationAsync.completion
RPC method for generating text completions in asynchronous mode.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/completionAsync
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
messages[].<br>role | **string**<br><p>Identifier of the message sender. Supported roles:</p> <ul> <li>``system`` - special role used to define the behaviour of the completion model</li> <li>``assistant`` - a role used by the model to generate responses</li> <li>``user`` - a role used by the user to describe requests to the model</li> </ul> 
messages[].<br>text | **string**<br><p>Textual content of the message.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 