---
editable: false
---

# Method list
Retrieves the list of agent instances in the specified folder
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/agents
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. The maximum string length in characters is 50.</p> 
pageSize | <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "folderId": "string",
  "agentInstances": [
    {
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**
agentInstances[] | **object**
agentInstances[].<br>id | **string**
agentInstances[].<br>folderId | **string**
agentInstances[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
agentInstances[].<br>computeInstanceUpdatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
agentInstances[].<br>name | **string**
agentInstances[].<br>description | **string**
agentInstances[].<br>labels | **object**
agentInstances[].<br>serviceAccountId | **string**
agentInstances[].<br>presetId | **string**
agentInstances[].<br>yandexTankVersion | **string**
agentInstances[].<br>status | **string**<br><p>Current status: current job, errors, Status</p> 
agentInstances[].<br>errors[] | **string**
agentInstances[].<br>currentJob | **string**
agentInstances[].<br>computeInstanceId | **string**<br><p>Compute Instance Id and status</p> 
agentInstances[].<br>agentVersion | **object**
agentInstances[].<br>agentVersion.<br>id | **string**
agentInstances[].<br>agentVersion.<br>status | **string**
agentInstances[].<br>agentVersion.<br>revision | **string** (int64)
agentInstances[].<br>agentVersion.<br>description | **string**
agentInstances[].<br>agentVersion.<br>statusComment | **string**
nextPageToken | **string**