---
editable: false
---

# Method stats

 

 
## HTTP request {#https-request}
```
GET undefined/logging/v1/logGroups/{logGroupId}/stats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | Required. The maximum string length in characters is 64.
 
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
logGroupId | **string**<br>
bytes | **string** (int64)<br>
records | **string** (int64)<br>