---
editable: false
sourcePath: en/_api-ref/ydb/api-ref/Backup/listPaths.md
---

# Method listPaths

 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/backups/{backupId}/paths
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | Required. Required. ID of the YDB backup.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListPaths requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListPaths request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "paths": [
    "string"
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
paths[] | **string**<br>
nextPageToken | **string**<br>