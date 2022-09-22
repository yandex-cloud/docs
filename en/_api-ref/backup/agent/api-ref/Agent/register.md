---
editable: false
---

# Method register

 

 
## HTTP request {#https-request}
```
POST https://backup.{{ api-host }}/backup/agent/v1/api/registerAgent
```
 
## Body parameters {#body_params}
 
```json 
{
  "instanceId": "string",
  "agentId": "string"
}
```

 
Field | Description
--- | ---
instanceId | **string**<br><p>Required.</p> 
agentId | **string**<br><p>Required.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 