---
editable: false
sourcePath: en/_api-ref/iot/devices/api-ref/Registry/index.md
---

# IoT Core Service, REST: Registry methods
A set of methods for managing registry.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "logGroupId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the registry.</p> 
folderId | **string**<br><p>ID of the folder that the registry belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the registry. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the registry. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br><p>Status of the registry.</p> <ul> <li>CREATING: Registry is being created.</li> <li>ACTIVE: Registry is ready to use.</li> <li>DELETING: Registry is being deleted.</li> </ul> 
logGroupId | **string**<br><p>ID of the logs group for the specified registry.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addCertificate](addCertificate.md) | Adds a certificate.
[addPassword](addPassword.md) | Adds password for the specified registry.
[create](create.md) | Creates a registry in the specified folder.
[delete](delete.md) | Deletes the specified registry.
[deleteCertificate](deleteCertificate.md) | Deletes the specified registry certificate.
[deletePassword](deletePassword.md) | Deletes the specified password.
[get](get.md) | Returns the specified registry.
[getByName](getByName.md) | 
[list](list.md) | Retrieves the list of registries in the specified folder.
[listCertificates](listCertificates.md) | Retrieves the list of registry certificates for the specified registry.
[listDeviceTopicAliases](listDeviceTopicAliases.md) | Retrieves the list of device topic aliases for the specified registry.
[listOperations](listOperations.md) | Lists operations for the specified registry.
[listPasswords](listPasswords.md) | Retrieves the list of passwords for the specified registry.
[update](update.md) | Updates the specified registry.