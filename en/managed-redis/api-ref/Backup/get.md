---
editable: false
sourcePath: en/_api-ref/mdb/redis/api-ref/Backup/get.md
---

# Method get
Returns the specified Redis backup.
 
To get the list of available Redis backups, make a [list](/docs/managed-redis/api-ref/Backup/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-redis/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. ID of the Redis backup to return. To get the backup ID, use a <a href="/docs/managed-redis/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "sourceShardNames": [
    "string"
  ]
}
```
Description of a Redis backup. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/backup).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the Redis cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Start timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was started).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceShardNames[] | **string**<br><p>Shard names used as a source for backup.</p> 