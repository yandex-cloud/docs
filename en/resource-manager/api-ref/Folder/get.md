---
editable: false
sourcePath: en/_api-ref/resourcemanager/api-ref/Folder/get.md
---

# Resource Manager API, REST: Folder.get
Returns the specified Folder resource.
 
To get the list of available Folder resources, make a [list](/docs/resource-manager/api-ref/Folder/list) request.
 
## HTTP request {#https-request}
```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/folders/{folderId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the Folder resource to return. To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string"
}
```
A Folder resource. For more information, see [Folder](/docs/resource-manager/concepts/resources-hierarchy#folder).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the folder.</p> 
cloudId | **string**<br><p>ID of the cloud that the folder belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the folder. The name is unique within the cloud. 3-63 characters long.</p> 
description | **string**<br><p>Description of the folder. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br><p>Status of the folder.</p> <ul> <li>ACTIVE: The folder is active.</li> <li>DELETING: The folder is being deleted.</li> <li>PENDING_DELETION: Stopping folder resources and waiting for the deletion start timestamp.</li> </ul> 