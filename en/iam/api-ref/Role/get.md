---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Role/get.md
---

# Identity and Access Management API, REST: Role.get
Returns the specified Role resource.
 
To get the list of available Role resources, make a [list](/docs/iam/api-ref/Role/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/roles/{roleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
roleId | <p>Required. ID of the Role resource to return. To get the role ID, use a <a href="/docs/iam/api-ref/Role/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string"
}
```
A Role resource. For more information, see [Roles](/docs/iam/concepts/access-control/roles).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the role.</p> 
description | **string**<br><p>Description of the role. 0-256 characters long.</p> 