---
editable: false
---

# Backup

## JSON Representation {#representation}
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
sourceClusterId | **string**<br><p>ID of the associated OpenSearch cluster.</p> 
startedAt | **string** (date-time)<br><p>The time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdAt | **string** (date-time)<br><p>The time when the backup was created (i.e. when the backup operation completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
indices[] | **string**<br><p>Indices names. (max 100)</p> <p>The maximum number of elements is 100.</p> 
opensearchVersion | **string**<br><p>OpenSearch version used to create the snapshot</p> 
sizeBytes | **string** (int64)<br><p>Total size of all indices in backup. in bytes</p> 
indicesTotal | **string** (int64)<br><p>Total count of indices in backup</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified backup of OpenSearch cluster.
[list](list.md) | Returns the list of available backups for the specified OpenSearch cluster.