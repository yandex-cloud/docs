---
editable: false
---

# Method get
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
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the placement group.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
zoneId | **string**<br><p>ID of the availability zone where the placement group resides.</p> 
status | **string**<br>Current status of the placement group<br>
spreadPlacementStrategy | **object**<br>Distribute instances over distinct failure domains.<br>