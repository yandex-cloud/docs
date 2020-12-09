---
editable: false
---

# Method createVersion
Creates a version for the specified function.
 

 
## HTTP request {#https-request}
```
POST https://serverless-functions.api.cloud.yandex.net/functions/v1/versions
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
  "tag": [
    "string"
  ],
  "connectivity": {
    "networkId": "string",
    "subnetId": [
      "string"
    ]
  },

  //  includes only one of the fields `package`, `content`, `versionId`
  "package": {
    "bucketName": "string",
    "objectName": "string",
    "sha256": "string"
  },
  "content": "string",
  "versionId": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
functionId | **string**<br><p>Required. ID of the function to create a version for.</p> <p>To get a function ID, make a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
runtime | **string**<br><p>Required. Runtime environment for the version.</p> 
description | **string**<br><p>Description of the version</p> <p>The string length in characters must be 0-256.</p> 
entrypoint | **string**<br><p>Required. Entrypoint of the version.</p> 
resources | **object**<br>Required. Resources allocated to the version.<br><p>Resources allocated to a version.</p> 
resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the version, specified in bytes.</p> <p>Acceptable values are 134217728 to 2147483648, inclusive.</p> 
executionTimeout | **string**<br><p>Required. Timeout for the execution of the version.</p> <p>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code.</p> 
serviceAccountId | **string**<br><p>ID of the service account to associate with the version.</p> 
environment | **object**<br><p>Environment settings for the version.</p> <p>Each key must match the regular expression `` [a-zA-Z][a-zA-Z0-9_]* ``. The maximum string length in characters for each value is 4096.</p> 
tag[] | **string**<br><p>Function version tags. For details, see <a href="/docs/functions/concepts/function#tag">Version tag</a>.</p> <p>Each value must match the regular expression `` [a-z][-_0-9a-z]* ``.</p> 
connectivity | **object**<br>Function version connectivity. If specified the version will be attached to specified network/subnet(s).<br><p>Version connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the version will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.</p> 
package | **object**<br>Functions deployment package. <br> includes only one of the fields `package`, `content`, `versionId`<br><br><p>Version deployment package.</p> 
package.<br>bucketName | **string**<br><p>Required. Name of the bucket that stores the code for the version.</p> 
package.<br>objectName | **string**<br><p>Required. Name of the object in the bucket that stores the code for the version.</p> 
package.<br>sha256 | **string**<br><p>SHA256 hash of the version deployment package.</p> 
content | **string** (byte) <br> includes only one of the fields `package`, `content`, `versionId`<br><br><p>Content of the deployment package.</p> <p>The maximum string length in characters is 52428800.</p> 
versionId | **string** <br> includes only one of the fields `package`, `content`, `versionId`<br><br><p>ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 