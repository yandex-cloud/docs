---
editable: false
sourcePath: en/_api-ref/iot/devices/api-ref/Registry/getByName.md
---

# Method getByName

 

 
## HTTP request {#https-request}
```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/registries:getByName
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list registries in.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
registryName | <p>Required. Name of the registry to return.</p> <p>To get a registry Name make a <a href="/docs/iot-core/api-ref/Registry/list">list</a> request.</p> <p>The maximum string length in characters is 50. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the registry. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the registry. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br><p>Status of the registry.</p> <ul> <li>CREATING: Registry is being created.</li> <li>ACTIVE: Registry is ready to use.</li> <li>DELETING: Registry is being deleted.</li> </ul> 
logGroupId | **string**<br><p>ID of the logs group for the specified registry.</p> 