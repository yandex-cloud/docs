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
  "signal": "string",
  "waitDuration": "number",
  "runIn": "number"
}
```

 
Field | Description
--- | ---
signal | **string**
waitDuration | **number** (double)
runIn | **number** (double)