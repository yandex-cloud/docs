---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Bus/index.md
---

# EventRouter Service, REST: Bus methods
A set of methods for managing buses for serverless eventrouter.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": true,
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the bus.</p> 
folderId | **string**<br><p>ID of the folder that the bus belongs to.</p> 
cloudId | **string**<br><p>ID of the cloud that the bus resides in.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the bus.</p> 
description | **string**<br><p>Description of the bus.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion protection.</p> 
status | **string**<br><p>Status of the bus.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a bus in the specified folder.
[delete](delete.md) | Deletes the specified bus.
[get](get.md) | Returns the specified bus. To get the list of all available buses, make a [list](/docs/functions/eventrouter/api-ref/Bus/list) request.
[list](list.md) | Retrieves the list of buses in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified bus.
[listOperations](listOperations.md) | Lists operations for the specified bus.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the bus.
[update](update.md) | Updates the specified bus.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified bus.