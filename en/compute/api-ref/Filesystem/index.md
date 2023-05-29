---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Filesystem/index.md
---

# Compute Cloud API, REST: Filesystem methods
A set of methods for managing filesystems.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the filesystem. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the filesystem belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the filesystem. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the filesystem.</p> 
labels | **object**<br><p>Filesystem labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
typeId | **string**<br><p>ID of the filesystem type.</p> <p>To get a list of available filesystem types, make a <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> 
zoneId | **string**<br><p>ID of the availability zone where the filesystem resides.</p> <p>A filesystem can be attached only to instances residing in the same availability zone.</p> 
size | **string** (int64)<br><p>Size of the filesystem, specified in bytes.</p> 
blockSize | **string** (int64)<br><p>Block size used for the filesystem, specified in bytes.</p> 
status | **string**<br><p>Current status of the filesystem.</p> <ul> <li>CREATING: The filesystem is being created.</li> <li>READY: The filesystem is ready to use.</li> <li>ERROR: The filesystem encountered a problem and cannot operate.</li> <li>DELETING: The filesystem is being deleted.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a filesystem in the specified folder.
[delete](delete.md) | Deletes the specified filesystem.
[get](get.md) | Returns the specified filesystem.
[list](list.md) | Lists filesystems in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified filesystem.
[update](update.md) | Updates the specified filesystem.