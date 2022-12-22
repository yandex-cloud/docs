---
editable: false
---

# Service Name API, REST: ResourceName methods
A set of methods for managing resource names.
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
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource name. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the resource name belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the resource name. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the resource name.</p> 
labels | **object**<br><p>Resource name labels as ``key:value`` pairs.</p> 
zoneId | **string**<br><p>ID of the availability zone where the resource name resides.</p> 
status | **string**<br><p>Status of the resource name.</p> <ul> <li>CREATING: Resource name is being created.</li> <li>READY: Resource name is ready to use.</li> <li>ERROR: Resource name encountered a problem and cannot operate.</li> <li>DELETING: Resource name is being deleted.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a resource name in the specified folder.
[delete](delete.md) | Deletes the specified resource name.
[get](get.md) | Returns the specified resource name.
[list](list.md) | Retrieves the list of resource names in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified resource name.
[listOperations](listOperations.md) | Lists operations for the specified resource name.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the resource name.
[update](update.md) | Updates the specified resource name.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified resource name.