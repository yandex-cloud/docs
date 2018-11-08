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