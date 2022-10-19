---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/api-ref/Backup/get.md
---

# Method get
Returns the specified PostgreSQL Backup resource.
 
To get the list of available PostgreSQL Backup resources, make a [list](/docs/managed-postgresql/api-ref/Backup/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. ID of the backup to return information about. To get the backup ID, use a <a href="/docs/managed-postgresql/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "size": "string",
  "type": "string",
  "method": "string",
  "journalSize": "string"
}
```
A PostgreSQL Backup resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts/backup).
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the PostgreSQL cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
size | **string** (int64)<br><p>Size of backup, in bytes</p> 
type | **string**<br><p>How this backup was created (manual/automatic/etc...)</p> <ul> <li>AUTOMATED: Backup created by automated daily schedule</li> <li>MANUAL: Backup created by user request</li> </ul> 
method | **string**<br><p>Method of backup creation</p> <ul> <li>BASE: Base backup</li> <li>INCREMENTAL: Delta (incremental) PostgreSQL backup</li> </ul> 
journalSize | **string** (int64)<br><p>Size of the journal associated with backup, in bytes</p> 