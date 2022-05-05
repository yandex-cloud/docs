---
editable: false
sourcePath: en/_api-ref/iam/api-ref/AccessKey/create.md
---

# Method create
Creates an access key for the specified service account.
 

 
## HTTP request {#https-request}
```
POST https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
```
 
## Body parameters {#body_params}
 
```json 
{
  "serviceAccountId": "string",
  "description": "string"
}
```

 
Field | Description
--- | ---
serviceAccountId | **string**<br><p>ID of the service account to create an access key for. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request. If not specified, it defaults to the subject that made the request.</p> <p>The maximum string length in characters is 50.</p> 
description | **string**<br><p>Description of the access key.</p> <p>The maximum string length in characters is 256.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "accessKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "string",
    "description": "string",
    "keyId": "string"
  },
  "secret": "string"
}
```

 
Field | Description
--- | ---
accessKey | **object**<br><p>AccessKey resource.</p> <p>An access key. For more information, see <a href="/docs/iam/concepts/authorization/access-key">AWS-compatible access keys</a>.</p> 
accessKey.<br>id | **string**<br><p>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key.</p> 
accessKey.<br>serviceAccountId | **string**<br><p>ID of the service account that the access key belongs to.</p> 
accessKey.<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
accessKey.<br>description | **string**<br><p>Description of the access key. 0-256 characters long.</p> 
accessKey.<br>keyId | **string**<br><p>ID of the access key. The key is AWS compatible.</p> 
secret | **string**<br><p>Secret access key. The key is AWS compatible.</p> 