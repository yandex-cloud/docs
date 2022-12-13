---
editable: false
sourcePath: en/_api-ref/organizationmanager/api-ref/Group/index.md
---

# Cloud Organization API, REST: Group methods
A set of methods for managing groups.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "organizationId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the group.</p> 
organizationId | **string**<br><p>ID of the organization that the group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the group.</p> 
description | **string**<br><p>Description of the group.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a group in the specified organization.
[delete](delete.md) | Deletes the specified group.
[get](get.md) | Returns the specified Group resource.
[list](list.md) | Retrieves the list of group resources.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified group.
[listMembers](listMembers.md) | List group active members.
[listOperations](listOperations.md) | Lists operations for the specified group.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified group.
[update](update.md) | Updates the specified group.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified group.
[updateMembers](updateMembers.md) | Update group members.