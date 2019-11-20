---
editable: false
---

# Method get
Returns the specified ServiceAccount resource.
 
To get the list of available ServiceAccount resources, make a [list](/docs/iam/api-ref/ServiceAccount/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/{serviceAccountId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
serviceAccountId | Required. ID of the ServiceAccount resource to return. To get the service account ID, use a [list](/docs/iam/api-ref/ServiceAccount/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```
A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the service account.</p> 
folderId | **string**<br><p>ID of the folder that the service account belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the service account. The name is unique within the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the service account. 0-256 characters long.</p> 