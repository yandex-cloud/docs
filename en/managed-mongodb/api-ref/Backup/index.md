---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/api-ref/Backup/index.md
---

# Backup
A set of methods for managing MongoDB Backup resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "sourceShardNames": [
    "string"
  ],
  "size": "string",
  "type": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup. Required.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the MongoDB cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceShardNames[] | **string**<br><p>Shard names used as a source for backup.</p> 
size | **string** (int64)<br><p>Size of backup in bytes</p> 
type | **string**<br><p>How this backup was created (manual/automatic/etc...)</p> <ul> <li>AUTOMATED: Backup created by automated daily schedule</li> <li>MANUAL: Backup created by user request</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[delete](delete.md) | Returns the list of available backups for the specified MongoDB cluster.
[get](get.md) | Returns the specified MongoDB backup.
[list](list.md) | Retrieves the list of backups available for the specified folder.