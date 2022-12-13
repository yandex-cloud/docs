---
editable: false
sourcePath: en/_api-ref/resourcemanager/api-ref/Cloud/index.md
---

# Resource Manager API, REST: Cloud methods
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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