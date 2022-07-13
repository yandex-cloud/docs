---
editable: false
---

# Method claimStatus
Claims status for the specified agent.
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/agents/{agentInstanceId}/claimStatus
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
agentInstanceId | 
 
## Body parameters {#body_params}
 
```json 
{
  "status": "string"
}
```

 
Field | Description
--- | ---
status | **string**
 
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