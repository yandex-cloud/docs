---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Backup/get.md
---

# Method get
Returns the specified backup of Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-elasticsearch/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. Required. ID of the backup to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "createdAt": "string",
  "indices": [
    "string"
  ],
  "elasticsearchVersion": "string",
  "sizeBytes": "string",
  "indicesTotal": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
sourceClusterId | **string**<br><p>ID of the associated Elasticsearch cluster.</p> 
startedAt | **string** (date-time)<br><p>The time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdAt | **string** (date-time)<br><p>The time when the backup was created (i.e. when the backup operation completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
indices[] | **string**<br><p>Indices names. (max 100)</p> <p>The maximum number of elements is 100.</p> 
elasticsearchVersion | **string**<br><p>Elasticsearch version used to create the snapshot</p> 
sizeBytes | **string** (int64)<br><p>Total size of all indices in backup. in bytes</p> 
indicesTotal | **string** (int64)<br><p>Total count of indices in backup</p> 