---
editable: false
---

# Title not set., REST: Job.get
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
id | **string**
config | **string**
ammo | **object**
ammo.<br>name | **string**
ammo.<br>content | **string** (byte)
loggingLogGroupId | **string**
testData | **object**
testData.<br>objectStorageBucket | **string**
testData.<br>objectStorageFilename | **string**