---
editable: false
---

# Method get
Retrieves information about the specified backup.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. ID of the backup to return information about.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Backup/list">list</a> request (lists all backups in a folder) or a <a href="/docs/managed-mysql/api-ref/Cluster/listBackups">listBackups</a> request (lists all backups for an existing cluster).</p> 
 
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
An object that represents MySQL backup.

See [the documentation](/docs/managed-mysql/concepts/backup) for details.
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp (the time when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Start timestamp (the time when the backup operation was started).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 