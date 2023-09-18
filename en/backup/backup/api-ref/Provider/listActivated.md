---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Provider/listActivated.md
---

# Cloud Backup API, REST: Provider.listActivated
List activated providers for specified client.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/providers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to find out the backup provider.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "folderId": "string",
  "names": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Folder ID.</p> 
names[] | **string**<br><p>Name of the backup provider.</p> 