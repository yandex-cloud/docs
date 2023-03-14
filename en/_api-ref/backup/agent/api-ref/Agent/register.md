---
editable: false
---

# Cloud Backup Agent API, REST: Agent.register

 

 
## HTTP request {#https-request}
```
POST https://backup.{{ api-host }}/backup/agent/v1/api/registerAgent
```
 
## Body parameters {#body_params}
 
```json 
{
  "instanceId": "string",
  "agentId": "string",
  "instanceName": "string"
}
```

 
Field | Description
--- | ---
instanceId | **string**<br><p>Required.</p> 
agentId | **string**<br><p>Required.</p> 
instanceName | **string**
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 