---
editable: false
sourcePath: en/_api-ref/compute/api-ref/DiskPlacementGroup/index.md
---

# DiskPlacementGroup
A set of methods for managing DiskPlacementGroup resources.
## JSON Representation {#representation}
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
status | **string**<br>Current status of the placement group
spreadPlacementStrategy | **object**

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a placement group in the specified folder.
[delete](delete.md) | Deletes the specified placement group.
[get](get.md) | Returns the specified placement group.
[list](list.md) | Retrieves the list of placement groups in the specified folder.
[listDisks](listDisks.md) | Lists disks for the specified placement group.
[listOperations](listOperations.md) | Lists operations for the specified placement group.
[update](update.md) | Updates the specified placement group.