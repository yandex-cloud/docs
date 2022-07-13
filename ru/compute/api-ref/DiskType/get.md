---
editable: false
sourcePath: en/_api-ref/compute/api-ref/DiskType/get.md
---

# Method get
Returns the information about specified disk type.
 
To get the list of available disk types, make a [list](/docs/compute/api-ref/DiskType/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/diskTypes/{diskTypeId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
diskTypeId | <p>Required. ID of the disk type to return information about. To get the disk type ID use a <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "zoneIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the disk type.</p> 
description | **string**<br><p>Description of the disk type. 0-256 characters long.</p> 
zoneIds[] | **string**<br><p>Array of availability zones where the disk type is available.</p> 