---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/TextGenerationAsync/instruct.md
---

# YandexGPT API, REST: TextGenerationAsync.instruct
RPC method for instructing the model to generate text.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/llm/v1alpha/instructAsync
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