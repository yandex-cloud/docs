---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/get.md
---

# DataSphere API v2, REST: Community.get
Returns community.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
communityId | <p>Required. ID of the community.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "createdById": "string",
  "organizationId": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the community.</p> 
createdAt | **string** (date-time)<br><p>Time when community was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the community.</p> 
description | **string**<br><p>Description of the comminuty.</p> 
labels | **object**<br><p>Labels of the community.</p> 
createdById | **string**<br><p>ID of the user who created the community.</p> 
organizationId | **string**<br><p>ID of the organization to which community belongs.</p> 