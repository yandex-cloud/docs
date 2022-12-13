---
editable: false
---

# Cloud Organization API, REST: Organization methods
A set of methods for managing Organization resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "title": "string",
  "labels": "object"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the organization.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the organization. 3-63 characters long.</p> 
description | **string**<br><p>Description of the organization. 0-256 characters long.</p> 
title | **string**<br><p>Display name of the organization. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified Organization resource.
[list](list.md) | Retrieves the list of Organization resources.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified organization.
[listOperations](listOperations.md) | Lists operations for the specified organization.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified organization.
[update](update.md) | Updates the specified organization.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified organization.