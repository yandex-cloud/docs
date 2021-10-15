---
editable: false
---

# Cloud
A set of methods for managing Cloud resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "organizationId": "string",
  "labels": "object"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the cloud.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the cloud. 0-256 characters long.</p> 
organizationId | **string**<br><p>ID of the organization that the cloud belongs to.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a cloud in the specified organization.
[get](get.md) | Returns the specified Cloud resource.
[list](list.md) | Retrieves the list of Cloud resources.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified cloud.
[listOperations](listOperations.md) | Lists operations for the specified cloud.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified cloud.
[update](update.md) | Updates the specified cloud.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified cloud.