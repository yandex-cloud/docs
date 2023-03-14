---
editable: false
---

# Cloud Backup Agent API, REST: Agent.issueToken

 

 
## HTTP request {#https-request}
```
POST https://backup.{{ api-host }}/backup/agent/v1/api/issueToken
```
 
## Body parameters {#body_params}
 
```json 
{
  "instanceId": "string"
}
```

 
Field | Description
--- | ---
instanceId | **string**
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "registrationToken": "string",
  "registrationUrl": "string"
}
```

 
Field | Description
--- | ---
registrationToken | **string**
registrationUrl | **string**