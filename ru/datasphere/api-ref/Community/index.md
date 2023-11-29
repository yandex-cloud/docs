---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/index.md
---

# DataSphere API v2, REST: Community methods
A set of methods for managing Community resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "createdById": "string",
  "organizationId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the community.</p> 
createdAt | **string** (date-time)<br><p>Time when community was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the community.</p> 
description | **string**<br><p>Description of the comminuty.</p> 
labels | **object**<br><p>Labels of the community.</p> 
createdById | **string**<br><p>ID of the user who created the community.</p> 
organizationId | **string**<br><p>ID of the organization to which community belongs.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates community in specified organization.
[delete](delete.md) | Deletes specified community.
[get](get.md) | Returns community.
[list](list.md) | List communities in specified organization.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for specified community.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for specified community.
[update](update.md) | Updates specified community.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for specified community.