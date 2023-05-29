---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceAccount/get.md
---

# Identity and Access Management API, REST: ServiceAccount.get
Returns the specified ServiceAccount resource.
 
To get the list of available ServiceAccount resources, make a [list](/docs/iam/api-ref/ServiceAccount/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/serviceAccounts/{serviceAccountId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
serviceAccountId | <p>Required. ID of the ServiceAccount resource to return. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object"
}
```
A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the service account.</p> 
folderId | **string**<br><p>ID of the folder that the service account belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the service account. The name is unique within the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the service account. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 