---
editable: false
sourcePath: en/_api-ref/storage/api-ref/Bucket/setHTTPSConfig.md
---

# Method setHTTPSConfig
Updates the HTTPS configuration for the specified bucket.
 
The updated configuration could take up to 30 minutes to apply to the bucket.
 
## HTTP request {#https-request}
```
POST https://storage.{{ api-host }}/storage/v1/buckets/{name}:setHttpsConfig
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | <p>Required. Name of the bucket to update the HTTPS configuration for.</p> 
 
## Body parameters {#body_params}
 
```json 
{

  //  includes only one of the fields `selfManaged`, `certificateManager`
  "selfManaged": {
    "certificatePem": "string",
    "privateKeyPem": "string"
  },
  "certificateManager": {
    "certificateId": "string"
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
selfManaged | **object**<br>Your TLS certificate, uploaded directly.  Object Storage only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates. <br> includes only one of the fields `selfManaged`, `certificateManager`<br>
selfManaged.<br>certificatePem | **string**<br><p><a href="https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail">PEM</a>-encoded certificate.</p> <p>The maximum string length in characters is 3145728.</p> 
selfManaged.<br>privateKeyPem | **string**<br><p><a href="https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail">PEM</a>-encoded private key for the certificate.</p> <p>The maximum string length in characters is 3145728.</p> 
certificateManager | **object**<br>TLS certificate from Certificate Manager.  To create a certificate in Certificate Manager, make a [create](/docs/certificate-manager/api-ref/Certificate/create) request. <br> includes only one of the fields `selfManaged`, `certificateManager`<br>
certificateManager.<br>certificateId | **string**<br><p>ID of the certificate.</p> <p>To get the list of all available certificates, make a <a href="/docs/certificate-manager/api-ref/Certificate/list">list</a> request.</p> 
 
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