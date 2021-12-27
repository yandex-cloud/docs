---
editable: false
sourcePath: en/_api-ref/iam/api-ref/AccessKey/get.md
---


# Method get
Returns the specified access key.
 
To get the list of available access keys, make a [list](/docs/iam/api-ref/AccessKey/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys/{accessKeyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
accessKeyId | Required. ID of the AccessKey resource to return. To get the access key ID, use a [list](/docs/iam/api-ref/AccessKey/list) request.  The maximum string length in characters is 50.
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the access key. 0-256 characters long.</p> 
keyId | **string**<br><p>ID of the access key. The key is AWS compatible.</p> 