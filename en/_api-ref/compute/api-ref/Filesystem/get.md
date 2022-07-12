---
editable: false
---

# Method get
Returns the specified filesystem.
 
To get the list of available filesystems, make a [list](/docs/compute/api-ref/Filesystem/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/filesystems/{filesystemId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
filesystemId | <p>Required. ID of the filesystem to return.</p> <p>To get the filesystem ID, make a <a href="/docs/compute/api-ref/Filesystem/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "blockSize": "string",
  "status": "string"
}
```
A filesystem resource.
For details about the concept, see [documentation](/docs/compute/concepts/filesystem).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the filesystem. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the filesystem belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the filesystem. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the filesystem.</p> 
labels | **object**<br><p>Filesystem labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
typeId | **string**<br><p>ID of the filesystem type.</p> <p>To get a list of available filesystem types, make a <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> 
zoneId | **string**<br><p>ID of the availability zone where the filesystem resides.</p> <p>A filesystem can be attached only to instances residing in the same availability zone.</p> 
size | **string** (int64)<br><p>Size of the filesystem, specified in bytes.</p> 
blockSize | **string** (int64)<br><p>Block size used for the filesystem, specified in bytes.</p> 
status | **string**<br><p>Current status of the filesystem.</p> <ul> <li>CREATING: The filesystem is being created.</li> <li>READY: The filesystem is ready to use.</li> <li>ERROR: The filesystem encountered a problem and cannot operate.</li> <li>DELETING: The filesystem is being deleted.</li> </ul> 