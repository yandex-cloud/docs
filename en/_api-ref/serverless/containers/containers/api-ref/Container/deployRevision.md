---
editable: false
---

# Method deployRevision

 

 
## HTTP request {#https-request}
```
POST https://serverless-containers.{{ api-host }}/containers/v1/revisions:deploy
```
 
## Body parameters {#body_params}
 
```json 
{
  "containerId": "string",
  "description": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "imageSpec": {
    "imageUrl": "string",
    "command": {
      "command": [
        "string"
      ]
    },
    "args": {
      "args": [
        "string"
      ]
    },
    "environment": "object",
    "workingDir": "string"
  },
  "concurrency": "string",
  "secrets": [
    {
      "id": "string",
      "versionId": "string",
      "key": "string",
      "environmentVariable": "string"
    }
  ],
  "connectivity": {
    "networkId": "string",
    "subnetIds": [
      "string"
    ]
  },
  "provisionPolicy": {
    "minInstances": "string"
  }
}
```

 
Field | Description
--- | ---
containerId | **string**<br><p>Required.</p> 
description | **string**
resources | **object**<br><p>Required.</p> 
resources.<br>memory | **string** (int64)<br><p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
resources.<br>cores | **string** (int64)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
executionTimeout | **string**<br><p>The maximum value is 600 seconds.</p> 
serviceAccountId | **string**
imageSpec | **object**<br><p>Required.</p> 
imageSpec.<br>imageUrl | **string**<br><p>Required.</p> 
imageSpec.<br>command | **object**
imageSpec.<br>command.<br>command[] | **string**
imageSpec.<br>args | **object**
imageSpec.<br>args.<br>args[] | **string**
imageSpec.<br>environment | **object**<br><p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
imageSpec.<br>workingDir | **string**
concurrency | **string** (int64)
secrets[] | **object**
secrets[].<br>id | **string**
secrets[].<br>versionId | **string**
secrets[].<br>key | **string**
secrets[].<br>environmentVariable | **string**
connectivity | **object**
connectivity.<br>networkId | **string**
connectivity.<br>subnetIds[] | **string**
provisionPolicy | **object**
provisionPolicy.<br>minInstances | **string** (int64)
 
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
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 