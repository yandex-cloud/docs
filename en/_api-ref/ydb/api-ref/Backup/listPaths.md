---
editable: false
---

# Managed Service for YDB API, REST: Backup.listPaths

 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/backups/{backupId}/paths
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. Required. ID of the YDB backup.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``page_size``, the service returns a ``next_page_token`` that can be used to get the next page of results in subsequent ListPaths requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set ``page_token`` to the ``next_page_token`` returned by a previous ListPaths request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
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
paths[] | **string**
nextPageToken | **string**