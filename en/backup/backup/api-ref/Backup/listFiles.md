---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/listFiles.md
---

# Cloud Backup API, REST: Backup.listFiles
ListFiles of the backup.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/backups/{backupId}/files
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. Backup ID.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID.</p> 
sourceId | <p>Empty source will list disks of the backup.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "files": [
    {
      "id": "string",
      "parentId": "string",
      "type": "string",
      "fullPath": "string",
      "name": "string",
      "size": "string",
      "actions": {
        "restoreToDisk": true,
        "goToLocation": true
      },
      "modifiedAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
files[] | **object**<br><p>BackupFile represents a single unit of file or directory system inside the backup.</p> 
files[].<br>id | **string**<br><p>Required. ID of the item. Should be used as source ID in case of listing.</p> 
files[].<br>parentId | **string**<br><p>Might be empty if this is root directory.</p> 
files[].<br>type | **string**<br><p>Required. Type of the item.</p> <p>Type of the file.</p> 
files[].<br>fullPath | **string**<br><p>Required. Absolute path of the item.</p> 
files[].<br>name | **string**<br><p>Required. Name of the directory / file.</p> 
files[].<br>size | **string** (int64)<br><p>Size in bytes of the item.</p> 
files[].<br>actions | **object**<br><p>Required. Actions that might be done on the object.</p> 
files[].<br>actions.<br>restoreToDisk | **boolean** (boolean)<br><p>Allows to send request to restore item to disk</p> 
files[].<br>actions.<br>goToLocation | **boolean** (boolean)<br><p>Allows to move to location by id.</p> 
files[].<br>modifiedAt | **string** (date-time)<br><p>Required. String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 