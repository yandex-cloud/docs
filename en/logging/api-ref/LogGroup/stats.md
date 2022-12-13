---
editable: false
sourcePath: en/_api-ref/logging/api-ref/LogGroup/stats.md
---

# Cloud Logging Service, REST: LogGroup.stats
Returns stats for the specified log group.
 

 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/logGroups/{logGroupId}/stats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | <p>Required. ID of the log group to return stats for.</p> <p>To get a log group ID make a <a href="/docs/logging/api-ref/LogGroup/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
 
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