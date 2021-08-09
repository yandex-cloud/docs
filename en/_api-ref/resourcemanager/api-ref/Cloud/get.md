---
editable: false
---

# Method get
Returns the specified Cloud resource.
 
To get the list of available Cloud resources, make a [list](/docs/resource-manager/api-ref/Cloud/list) request.
 
## HTTP request {#https-request}
```
GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/{cloudId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
cloudId | Required. ID of the Cloud resource to return. To get the cloud ID, use a [list](/docs/resource-manager/api-ref/Cloud/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "organizationId": "string"
}
```
A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the cloud.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the cloud. 0-256 characters long.</p> 
organizationId | **string**<br><p>ID of the organization that the cloud belongs to.</p> 