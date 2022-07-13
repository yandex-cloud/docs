---
editable: false
---

# Method getSignal
Returns the signal for the specified job.
 

 
## HTTP request {#https-request}
```
GET undefined/loadtesting/agent/v1/jobs/{jobId}/getSignal
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
jobId | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "signal": "string"
}
```

 
Field | Description
--- | ---
signal | **string**