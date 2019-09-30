---
editable: false
---

# Repository
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
[get](get.md) | Returns the specified Repository resource.
[list](list.md) | Retrieves the list of Repository resources in the specified registry.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified repository.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified repository.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified repository.