---
editable: false
sourcePath: en/_api-ref/lockbox/v1/api-ref/Secret/update.md
---

# Lockbox API, REST: Secret.update
Updates the specified secret.
 

 
## HTTP request {#https-request}
```
PATCH https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
secretId | <p>Required. ID of the secret to update.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": true,
  "passwordPayloadSpecification": {
    "passwordKey": "string",
    "length": "string",
    "includeUppercase": true,
    "includeLowercase": true,
    "includeDigits": true,
    "includePunctuation": true,
    "includedPunctuation": "string",
    "excludedPunctuation": "string"
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br>Required. Field mask that specifies which attributes of the secret are going to be updated.
name | **string**<br><p>New name of the secret.</p> <p>The maximum string length in characters is 100.</p> 
description | **string**<br><p>New description of the secret.</p> <p>The maximum string length in characters is 1024.</p> 
labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the secret.</p> 
passwordPayloadSpecification | **object**
passwordPayloadSpecification.<br>passwordKey | **string**<br><p>Required. key of the entry to store generated password value</p> <p>The maximum string length in characters is 256. Value must match the regular expression ``[-_./\\@0-9a-zA-Z]+``.</p> 
passwordPayloadSpecification.<br>length | **string** (int64)<br><p>password length; by default, a reasonable length will be decided</p> <p>The maximum value is 256.</p> 
passwordPayloadSpecification.<br>includeUppercase | **boolean** (boolean)<br><p>whether at least one A..Z character is included in the password, true by default</p> 
passwordPayloadSpecification.<br>includeLowercase | **boolean** (boolean)<br><p>whether at least one a..z character is included in the password, true by default</p> 
passwordPayloadSpecification.<br>includeDigits | **boolean** (boolean)<br><p>whether at least one 0..9 character is included in the password, true by default</p> 
passwordPayloadSpecification.<br>includePunctuation | **boolean** (boolean)<br><p>whether at least one punctuation character is included in the password, true by default punctuation characters by default (there are 32): !"#$%&amp;'()*+,-./:;&lt;=&gt;?@[]^_`{\|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below</p> 
passwordPayloadSpecification.<br>includedPunctuation | **string**<br><p>If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use (at most, all the 32)</p> <p>The maximum string length in characters is 32.</p> 
passwordPayloadSpecification.<br>excludedPunctuation | **string**<br><p>a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)</p> <p>The maximum string length in characters is 31.</p> 
 
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