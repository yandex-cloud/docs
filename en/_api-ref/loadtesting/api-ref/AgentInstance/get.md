---
editable: false
---

# Method get
Returns the specified agent instance
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/agents/{agentInstanceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
agentInstanceId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "agentInstance": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "computeInstanceUpdatedAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "serviceAccountId": "string",
    "presetId": "string",
    "yandexTankVersion": "string",
    "status": "string",
    "errors": [
      "string"
    ],
    "currentJob": "string",
    "computeInstanceId": "string",
    "agentVersion": {
      "id": "string",
      "status": "string",
      "revision": "string",
      "description": "string",
      "statusComment": "string"
    }
  }
}
```

 
Field | Description
--- | ---
agentInstance | **object**
agentInstance.<br>id | **string**
agentInstance.<br>folderId | **string**
agentInstance.<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
agentInstance.<br>computeInstanceUpdatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
agentInstance.<br>name | **string**
agentInstance.<br>description | **string**
agentInstance.<br>labels | **object**
agentInstance.<br>serviceAccountId | **string**
agentInstance.<br>presetId | **string**
agentInstance.<br>yandexTankVersion | **string**
agentInstance.<br>status | **string**<br><p>Current status: current job, errors, Status</p> 
agentInstance.<br>errors[] | **string**
agentInstance.<br>currentJob | **string**
agentInstance.<br>computeInstanceId | **string**<br><p>Compute Instance Id and status</p> 
agentInstance.<br>agentVersion | **object**
agentInstance.<br>agentVersion.<br>id | **string**
agentInstance.<br>agentVersion.<br>status | **string**
agentInstance.<br>agentVersion.<br>revision | **string** (int64)
agentInstance.<br>agentVersion.<br>description | **string**
agentInstance.<br>agentVersion.<br>statusComment | **string**