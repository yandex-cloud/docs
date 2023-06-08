---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/AccessKey/get.md
---

# Identity and Access Management API, REST: AccessKey.get
Returns the specified access key.
 
To get the list of available access keys, make a [list](/docs/iam/api-ref/AccessKey/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys/{accessKeyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
accessKeyId | <p>Required. ID of the AccessKey resource to return. To get the access key ID, use a <a href="/docs/iam/api-ref/AccessKey/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string"
}
```
An access key.
For more information, see [AWS-compatible access keys](/docs/iam/concepts/authorization/access-key).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key.</p> 
serviceAccountId | **string**<br><p>ID of the service account that the access key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
description | **string**<br><p>Description of the access key. 0-256 characters long.</p> 
keyId | **string**<br><p>ID of the access key. The key is AWS compatible.</p> 