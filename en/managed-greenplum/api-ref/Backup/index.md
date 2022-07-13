---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/api-ref/Backup/index.md
---

# Backup
A set of methods for managing backups.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "size": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Time when the backup operation was completed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the Greenplum® cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
size | **string** (int64)<br><p>Size of the backup in bytes.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified backup of Greenplum® cluster.
[list](list.md) | Returns the list of available backups for the specified Greenplum® cluster.