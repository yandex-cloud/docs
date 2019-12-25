---
editable: false
---

# Method get
Returns the specified placement group.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/placementGroups/{placementGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
placementGroupId | ID of the placement group to return. To get the placement group ID, use [list](/docs/compute/api-ref/PlacementGroup/list) request.
 
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
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> 
spreadPlacementStrategy | **object**<br>Distribute instances over distinct failure domains.<br>