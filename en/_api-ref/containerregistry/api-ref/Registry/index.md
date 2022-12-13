---
editable: false
---

# Container Registry API, REST: Registry methods
A set of methods for managing Registry resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "status": "string",
  "createdAt": "string",
  "labels": "object"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the registry.</p> 
folderId | **string**<br><p>ID of the folder that the registry belongs to.</p> 
name | **string**<br><p>Name of the registry.</p> 
status | **string**<br><p>Output only. Status of the registry.</p> <ul> <li>CREATING: Registry is being created.</li> <li>ACTIVE: Registry is ready to use.</li> <li>DELETING: Registry is being deleted.</li> </ul> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a registry in the specified folder.
[delete](delete.md) | Deletes the specified registry.
[get](get.md) | Returns the specified Registry resource.
[list](list.md) | Retrieves the list of Registry resources in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the specified registry.
[listIpPermission](listIpPermission.md) | List ip permissions for the specified registry.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified registry.
[setIpPermission](setIpPermission.md) | Set ip permissions for the specified registry.
[update](update.md) | Updates the specified registry.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified registry.
[updateIpPermission](updateIpPermission.md) | Update ip permissions for the specified registry.