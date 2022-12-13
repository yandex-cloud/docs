---
editable: false
---

# Compute Cloud API, REST: DiskPlacementGroup.get
Returns the specified placement group.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/diskPlacementGroups/{diskPlacementGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
diskPlacementGroupId | <p>Required. ID of the placement group to return. To get the placement group ID, use <a href="/docs/compute/api-ref/DiskPlacementGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "status": "string",
  "spreadPlacementStrategy": {}
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the placement group.</p> 
folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the placement group.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
zoneId | **string**<br><p>ID of the availability zone where the placement group resides.</p> 
status | **string**<br>Current status of the placement group
spreadPlacementStrategy | **object**<br>Distribute instances over distinct failure domains.