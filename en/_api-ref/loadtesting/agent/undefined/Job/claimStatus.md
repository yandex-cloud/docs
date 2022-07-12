---
editable: false
---

# Method claimStatus
Claims status for the specified job.
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/jobs/{jobId}/claimStatus
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
jobId | 
 
## Body parameters {#body_params}
 
```json 
{
  "status": "string",
  "error": "string"
}
```

 
Field | Description
--- | ---
status | **string**<br>
error | **string**<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "code": "string"
}
```

 
Field | Description
--- | ---
code | **string** (int64)<br>