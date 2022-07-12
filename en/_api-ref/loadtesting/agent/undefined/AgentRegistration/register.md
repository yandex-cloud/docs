---
editable: false
---

# Method register
Registers specified agent.
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/agents/register
```
 
## Body parameters {#body_params}
 
```json 
{
  "computeInstanceId": "string"
}
```

 
Field | Description
--- | ---
computeInstanceId | **string**<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "agentInstanceId": "string"
}
```

 
Field | Description
--- | ---
agentInstanceId | **string**<br>