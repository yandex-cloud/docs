---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/api-ref/Backup/index.md
---


# Backup
A set of methods for managing ClickHouse Backup resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the ClickHouse cluster that the backup was created for.</p> 
sourceShardNames[] | **string**<br><p>Names of the shards included in the backup.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified ClickHouse Backup resource.
[list](list.md) | Retrieves the list of Backup resources available for the specified folder.