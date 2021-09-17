---
editable: false
---

# Method stats
Returns stats for the specified log group.
 

 
## HTTP request {#https-request}
```
GET https://logging.api.cloud.yandex.net/logging/v1/logGroups/{logGroupId}/stats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | Required. ID of the log group to return stats for.  To get a log group ID make a [list](/docs/logging/api-ref/LogGroup/list) request.  The maximum string length in characters is 64.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logGroupId": "string",
  "bytes": "string",
  "records": "string"
}
```

 
Field | Description
--- | ---
logGroupId | **string**<br><p>Log group ID the stats are returned for.</p> 
bytes | **string** (int64)<br><p>Size of data in log group in bytes.</p> 
records | **string** (int64)<br><p>Amount of records in log group.</p> 