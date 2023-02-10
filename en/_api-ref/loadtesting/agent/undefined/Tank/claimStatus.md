---
editable: false
---

# Title not set., REST: Tank.claimStatus
Claims specified tank's status.
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/tanks/{computeInstanceId}/claimStatus
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
computeInstanceId | 
 
## Body parameters {#body_params}
 
```json 
{
  "status": "string",
  "error": "string"
}
```

 
Field | Description
--- | ---
status | **string**
error | **string**
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "code": "string"
}
```

 
Field | Description
--- | ---
code | **string** (int64)