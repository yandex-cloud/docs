---
editable: false
---

# Method validateConfig

 

 
## HTTP request {#https-request}
```
POST https://loadtesting.{{ api-host }}/loadtesting/v2/tests/validateConfig
```
 
## Body parameters {#body_params}
 
```json 
{
  "config": "string",
  "folderId": "string"
}
```

 
Field | Description
--- | ---
config | **string**<br><p>Required.</p> 
folderId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "status": "string",
  "errors": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
status | **string**
errors[] | **string**