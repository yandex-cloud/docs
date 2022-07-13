---
editable: false
sourcePath: en/_api-ref/organizationmanager/api-ref/Group/get.md
---

# Method get
Returns the specified Group resource.
 
To get the list of available Group resources, make a [list](/docs/organization/api-ref/Group/list) request.
 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups/{groupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
groupId | <p>Required. ID of the Group resource to return. To get the group ID, use a <a href="/docs/organization/api-ref/Group/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "organizationId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```
A Group resource.
For more information, see [Groups](/docs/organization/groups).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the group.</p> 
organizationId | **string**<br><p>ID of the organization that the group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the group.</p> 
description | **string**<br><p>Description of the group.</p> 