---
editable: false
sourcePath: en/_api-ref/serverless/functions/functions/api-ref/Function/listRuntimes.md
---

# Cloud Functions Service, REST: Function.listRuntimes
Lists available runtime environments for the specified function.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/runtimes
```
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "runtimes": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
runtimes[] | **string**<br><p>Runtime environments available for the specified function.</p> 