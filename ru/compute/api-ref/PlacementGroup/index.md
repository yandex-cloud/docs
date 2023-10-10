---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/PlacementGroup/index.md
---

# Compute Cloud API, REST: PlacementGroup methods
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

  //  includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
  "spreadPlacementStrategy": {},
  "partitionPlacementStrategy": {
    "partitions": "string"
  },
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the placement group. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the placement group. 0-256 characters long.</p> 
labels | **object**<br><p>Placement group labels as ``key:value`` pairs.</p> 
spreadPlacementStrategy | **object** <br> includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`<br><br><p>This is an empty structure that must be passed to explicitly specify the required placement strategy.</p> 
partitionPlacementStrategy | **object** <br> includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`<br>
partitionPlacementStrategy.<br>partitions | **string** (int64)<br><p>Acceptable values are 2 to 5, inclusive.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a placement group in the specified folder.
[delete](delete.md) | Deletes the specified placement group.
[get](get.md) | Returns the specified placement group.
[list](list.md) | Retrieves the list of placement groups in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the placement group.
[listInstances](listInstances.md) | Lists instances for the specified placement group.
[listOperations](listOperations.md) | Lists operations for the specified placement group.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the placement group.
[update](update.md) | Updates the specified placement group.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the placement group.