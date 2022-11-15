---
editable: false
---

# Method get
Returns the specified backup of an OpenSearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. ID of the backup to return.</p> 
 
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
  "opensearchVersion": "string",
  "sizeBytes": "string",
  "indicesTotal": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
sourceClusterId | **string**<br><p>ID of the OpenSearch cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdAt | **string** (date-time)<br><p>Time when the backup operation was completed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
indices[] | **string**<br><p>Names of indices in the backup.</p> <p>The maximum number of elements is 100.</p> 
opensearchVersion | **string**<br><p>OpenSearch version used to create the backup.</p> 
sizeBytes | **string** (int64)<br><p>Size of the backup in bytes.</p> 
indicesTotal | **string** (int64)<br><p>The number of indices in the backup.</p> 