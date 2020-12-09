---
editable: false
---

# Folder
A set of methods for managing Folder resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the folder.</p> 
cloudId | **string**<br><p>ID of the cloud that the folder belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the folder. The name is unique within the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the folder. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as `` key:value `` pairs. Мaximum of 64 per resource.</p> 
status | **string**<br><p>Status of the folder.</p> <ul> <li>ACTIVE: The folder is active.</li> <li>DELETING: The folder is being deleted.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a folder in the specified cloud.
[delete](delete.md) | Deletes the specified folder.
[get](get.md) | Returns the specified Folder resource.
[list](list.md) | Retrieves the list of Folder resources in the specified cloud.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified folder.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified folder.
[update](update.md) | Updates the specified folder.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified folder.