---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Backup/get.md
---

# Managed Service for MongoDB API, REST: Backup.get
Returns the specified MongoDB backup.
 
To get the list of available MongoDB backups, make a [list](/docs/managed-mongodb/api-ref/Backup/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. ID of the backup to return information about. To get the backup ID, use a <a href="/docs/managed-mongodb/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
 
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
  ],
  "size": "string",
  "type": "string",
  "journalSize": "string"
}
```
A MongoDB Backup resource. For more information, see the 
[Developer's Guide](/docs/managed-mongodb/concepts).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup. Required.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
sourceClusterId | **string**<br><p>ID of the MongoDB cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
sourceShardNames[] | **string**<br><p>Shard names used as a source for backup.</p> 
size | **string** (int64)<br><p>Size of backup in bytes</p> 
type | **string**<br><p>How this backup was created (manual/automatic/etc...)</p> <ul> <li>AUTOMATED: Backup created by automated daily schedule</li> <li>MANUAL: Backup created by user request</li> </ul> 
journalSize | **string** (int64)<br><p>Size of the journal associated with backup, in bytes</p> 