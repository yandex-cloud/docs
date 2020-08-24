---
editable: false
---

# Method get
Returns the specified SQLServer backup.
 
To get the list of available SQLServer backups, make a [list](/docs/managed-sqlserver/api-ref/Backup/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | Required. ID of the backup to return information about. To get the backup ID, use a [listBackups](/docs/managed-sqlserver/api-ref/Cluster/listBackups) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string"
}
```
A SQLServer Backup resource. For more information, see
the [Developer's Guide](/docs/managed-sqlserver/concepts/backup).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the SQLServer cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 