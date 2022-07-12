---
editable: false
---

# Method get
Returns the job for the specified agent.
 

 
## HTTP request {#https-request}
```
GET undefined/loadtesting/agent/v1/agents/{agentInstanceId}/getJob
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
agentInstanceId | 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
computeInstanceId | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "config": "string",
  "ammo": {
    "name": "string",
    "content": "string"
  },
  "loggingLogGroupId": "string",
  "testData": {
    "objectStorageBucket": "string",
    "objectStorageFilename": "string"
  }
}
```

 
Field | Description
--- | ---
id | **string**<br>
config | **string**<br>
ammo | **object**<br>
ammo.<br>name | **string**<br>
ammo.<br>content | **string** (byte)<br>
loggingLogGroupId | **string**<br>
testData | **object**<br>
testData.<br>objectStorageBucket | **string**<br>
testData.<br>objectStorageFilename | **string**<br>