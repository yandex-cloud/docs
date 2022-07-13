---
editable: false
---

# Method create
Creates a secret in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://lockbox.{{ api-host }}/lockbox/v1/secrets
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "kmsKeyId": "string",
  "versionDescription": "string",
  "versionPayloadEntries": [
    {
      "key": "string",

      // `versionPayloadEntries[]` includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string",
      // end of the list of possible fields`versionPayloadEntries[]`

    }
  ],
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a secret in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the secret.</p> <p>The maximum string length in characters is 100.</p> 
description | **string**<br><p>Description of the secret.</p> <p>The maximum string length in characters is 1024.</p> 
labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key. For example, ``"project": "mvp"`` or ``"source": "dictionary"``.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
kmsKeyId | **string**<br><p>Optional ID of the KMS key will be used to encrypt and decrypt the secret.</p> <p>The maximum string length in characters is 50.</p> 
versionDescription | **string**<br><p>Description of the first version.</p> <p>The maximum string length in characters is 256.</p> 
versionPayloadEntries[] | **object**<br><p>Payload entries added to the first version.</p> <p>The maximum number of elements is 32.</p> 
versionPayloadEntries[].<br>key | **string**<br><p>Required. Non-confidential key of the entry.</p> <p>The maximum string length in characters is 256. Value must match the regular expression ``[-_./\\@0-9a-zA-Z]+``.</p> 
versionPayloadEntries[].<br>textValue | **string** <br>`versionPayloadEntries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Use the field to set a text value.</p> <p>The maximum string length in characters is 65536.</p> 
versionPayloadEntries[].<br>binaryValue | **string** (byte) <br>`versionPayloadEntries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Use the field to set a binary value.</p> <p>The maximum string length in characters is 65536.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the secret.</p> 
 
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