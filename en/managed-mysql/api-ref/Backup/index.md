---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Backup/index.md
---


# Backup
A set of methods for managing MySQL backups.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
sourceClusterId | **string**<br><p>ID of the MySQL cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified MySQL backup.
[list](list.md) | Retrieves the list of MySQL backups available for the specified folder.