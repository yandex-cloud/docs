---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Backup/get.md
---


# Method get
Returns the specified MySQL backup.
 
To get the list of available MySQL backups, make a [list](/docs/managed-mysql/api-ref/Backup/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | Required. ID of the backup to return information about. To get the backup ID, use a [listBackups](/docs/managed-mysql/api-ref/Cluster/listBackups) request.
 
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
A MySQL backup. For more information, see
the [documentation](/docs/managed-mysql/concepts/backup).
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the MySQL cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 