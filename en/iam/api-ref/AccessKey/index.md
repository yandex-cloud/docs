---
editable: false
sourcePath: en/_api-ref/iam/api-ref/AccessKey/index.md
---


# AccessKey
A set of methods for managing access keys.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key.</p> 
serviceAccountId | **string**<br><p>ID of the service account that the access key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the access key. 0-256 characters long.</p> 
keyId | **string**<br><p>ID of the access key. The key is AWS compatible.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an access key for the specified service account.
[delete](delete.md) | Deletes the specified access key.
[get](get.md) | Returns the specified access key.
[list](list.md) | Retrieves the list of access keys for the specified service account.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified access key.
[update](update.md) | Updates the specified access key.