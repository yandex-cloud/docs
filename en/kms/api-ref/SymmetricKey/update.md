---
editable: false
sourcePath: en/_api-ref/kms/api-ref/SymmetricKey/update.md
---

# Method update
Updates the specified symmetric KMS key.
 

 
## HTTP request {#https-request}
```
PATCH https://kms.{{ api-host }}/kms/v1/keys/{keyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | <p>Required. ID of the symmetric KMS key to update. To get the ID of a symmetric KMS key use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "status": "string",
  "labels": "object",
  "defaultAlgorithm": "string",
  "rotationPeriod": "string",
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Required. Field mask that specifies which attributes of the symmetric KMS key are going to be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>New name for the symmetric KMS key.</p> <p>The maximum string length in characters is 100.</p> 
description | **string**<br><p>New description for the symmetric KMS key.</p> <p>The maximum string length in characters is 1024.</p> 
status | **string**<br><p>New status for the symmetric KMS key. Using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method you can only set ACTIVE or INACTIVE status.</p> <ul> <li>CREATING: The key is being created.</li> <li>ACTIVE: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method.</li> <li>INACTIVE: The key is inactive and unusable. Can be set to ACTIVE using the <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> method.</li> </ul> 
labels | **object**<br><p>Custom labels for the symmetric KMS key as ``key:value`` pairs. Maximum 64 per key.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
defaultAlgorithm | **string**<br><p>Default encryption algorithm to be used with new versions of the symmetric KMS key.</p> <p>Supported symmetric encryption algorithms.</p> <ul> <li>AES_128: AES algorithm with 128-bit keys.</li> <li>AES_192: AES algorithm with 192-bit keys.</li> <li>AES_256: AES algorithm with 256-bit keys.</li> <li>AES_256_HSM: AES algorithm with 256-bit keys hosted by HSM</li> </ul> 
rotationPeriod | **string**<br><p>Time period between automatic symmetric KMS key rotations.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the symmetric KMS key</p> 
 
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