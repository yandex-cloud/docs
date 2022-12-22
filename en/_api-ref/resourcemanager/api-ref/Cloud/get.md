---
editable: false
---

# Resource Manager API, REST: Cloud.get
Returns the specified Cloud resource.
 
To get the list of available Cloud resources, make a [list](/docs/resource-manager/api-ref/Cloud/list) request.
 
## HTTP request {#https-request}
```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/{cloudId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
cloudId | <p>Required. ID of the Cloud resource to return. To get the cloud ID, use a <a href="/docs/resource-manager/api-ref/Cloud/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "organizationId": "string",
  "labels": "object"
}
```
A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the cloud.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the cloud. 0-256 characters long.</p> 
organizationId | **string**<br><p>ID of the organization that the cloud belongs to.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 