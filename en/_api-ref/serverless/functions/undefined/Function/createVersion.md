---
editable: false
---

# Method createVersion

 

 
## HTTP request {#https-request}
```
POST undefined/functions/v1/versions
```
 
## Body parameters {#body_params}
 
```json 
{
  "functionId": "string",
  "runtime": "string",
  "description": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "environment": "object",

  //  includes only one of the fields `package`, `content`
  "package": {
    "bucketName": "string",
    "objectName": "string",
    "sha256": "string"
  },
  "content": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
functionId | **string**<br><p>Required.</p> 
runtime | **string**<br><p>Required.</p> 
description | **string**<br>
entrypoint | **string**<br><p>Required.</p> 
resources | **object**<br>Required.<br>
resources.<br>memory | **string** (int64)<br><p>Acceptable values are 33554432 to 1073741824, inclusive.</p> 
executionTimeout | **string**<br><p>Required.</p> 
serviceAccountId | **string**<br>
environment | **object**<br><p>Each key must match the regular expression <code>[a-zA-Z][a-zA-Z0-9_]*</code>. The maximum string length in characters for each value is 4096.</p> 
package | **object** <br> includes only one of the fields `package`, `content`<br><br>
package.<br>bucketName | **string**<br><p>Required.</p> 
package.<br>objectName | **string**<br><p>Required.</p> 
package.<br>sha256 | **string**<br>
content | **string** (byte) <br> includes only one of the fields `package`, `content`<br><br><p>The maximum string length in characters is 52428800.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 