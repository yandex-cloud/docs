---
editable: false
---

# Container Registry API, REST: Repository methods
A set of methods for managing Repository resources.
## JSON Representation {#representation}
```json 
{
  "name": "string",
  "id": "string"
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the repository. The name is unique within the registry.</p> 
id | **string**<br><p>Output only. ID of the repository.</p> 

## Methods {#methods}
Method | Description
--- | ---
[delete](delete.md) | Deletes the specified repository.
[get](get.md) | Returns the specified Repository resource.
[getByName](getByName.md) | Returns the specified Repository resource.
[list](list.md) | Retrieves the list of Repository resources in the specified registry.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified repository.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified repository.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified repository.
[upsert](upsert.md) | Upserts a repository in the specified registry.