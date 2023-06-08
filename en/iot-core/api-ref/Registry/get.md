---
editable: false
sourcePath: en/_api-ref/iot/devices/v1/api-ref/Registry/get.md
---

# IoT Core Service, REST: Registry.get
Returns the specified registry.
 
To get the list of available registries, make a [list](/docs/iot-core/api-ref/Registry/list) request.
 
## HTTP request {#https-request}
```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries/{registryId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | <p>Required. ID of the registry to return.</p> <p>To get a registry ID make a <a href="/docs/iot-core/api-ref/Registry/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A registry. For more information, see [Registry](/docs/iot-core/concepts/index#registry).
 
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