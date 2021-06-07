---
editable: false
---

# PlacementGroup
A set of methods for managing placement groups.
## JSON Representation {#representation}
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
id | **string**<br><p>ID of the placement group. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the placement group. 0-256 characters long.</p> 
labels | **object**<br><p>Placement group labels as ``key:value`` pairs.</p> 
spreadPlacementStrategy | **object**<br><p>This is an empty structure that must be passed to explicitly specify the required placement strategy.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a placement group in the specified folder.
[delete](delete.md) | Deletes the specified placement group.
[get](get.md) | Returns the specified placement group.
[list](list.md) | Retrieves the list of placement groups in the specified folder.
[listInstances](listInstances.md) | Lists instances for the specified placement group.
[listOperations](listOperations.md) | Lists operations for the specified placement group.
[update](update.md) | Updates the specified placement group.