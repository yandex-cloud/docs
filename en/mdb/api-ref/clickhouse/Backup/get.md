# Method get
Returns the specified ClickHouse Backup resource.
 
To get the list of available ClickHouse Backup resources, make a [list](/docs/mdb/api-ref/clickhouse/Backup/list) request.
 
## HTTP request {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/backups/{backupId}`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | Required. ID of the backup to return information about. To get the backup ID, use a [listBackups](/docs/mdb/api-ref/clickhouse/Cluster/listBackups) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

A ClickHouse Backup resource. See the [Developer's Guide](/docs/mdb/concepts)
for more information.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> 
sourceClusterId | **string**<br><p>ID of the ClickHouse cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> 