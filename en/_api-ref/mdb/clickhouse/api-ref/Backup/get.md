---
editable: false
---

# Method get
Returns the specified ClickHouse Backup resource.
 
To get the list of available ClickHouse Backup resources, make a [list](/docs/managed-clickhouse/api-ref/Backup/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. ID of the backup to return information about. To get the backup ID, use a <a href="/docs/managed-clickhouse/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "sourceShardNames": [
    "string"
  ],
  "startedAt": "string"
}
```
A ClickHouse Backup resource. See the [Developer's Guide](/docs/managed-clickhouse/concepts)
for more information.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the ClickHouse cluster that the backup was created for.</p> 
sourceShardNames[] | **string**<br><p>Names of the shards included in the backup.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 