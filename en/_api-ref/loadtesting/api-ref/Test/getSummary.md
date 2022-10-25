---
editable: false
---

# Method getSummary

 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/tests/{testId}/summary
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
testId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. The maximum string length in characters is 50.</p> 
full | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "testId": {
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "createdAt": "string",
    "startedAt": "string",
    "finishedAt": "string",
    "updatedAt": "string",
    "generator": "string",
    "agentInstanceId": "string",
    "targetAddress": "string",
    "targetPort": "string",
    "targetVersion": "string",
    "config": "string",
    "cases": [
      "string"
    ],
    "status": "string",
    "errors": [
      "string"
    ],
    "favorite": true,
    "imbalancePoint": "string",
    "imbalanceTs": "string",
    "imbalanceAt": "string",
    "imbalanceComment": "string",
    "autostops": [
      {
        "autostopType": "string",
        "autostopCriteria": "string",
        "autostopCase": "string"
      }
    ],
    "userId": "string",
    "testType": "string",
    "containerId": "string",
    "parts": [
      {
        "id": "string",
        "folderId": "string",
        "name": "string",
        "description": "string",
        "labels": "object",
        "createdAt": "string",
        "startedAt": "string",
        "finishedAt": "string",
        "updatedAt": "string",
        "generator": "string",
        "tankInstanceId": "string",
        "targetAddress": "string",
        "targetPort": "string",
        "targetVersion": "string",
        "cases": [
          "string"
        ],
        "status": "string",
        "errors": [
          "string"
        ],
        "favorite": true,
        "imbalancePoint": "string",
        "imbalanceTs": "string",
        "imbalanceAt": "string",
        "jobType": "string",
        "containerId": "string"
      }
    ],

    // `testId` includes only one of the fields `payloadUrls`, `payloadId`
    "payloadUrls": "string",
    "payloadId": "string",
    // end of the list of possible fields`testId`

  },
  "errors": [
    "string"
  ],
  "results": [
    {
      "caseName": "string",
      "quantiles": "object",
      "protoCodes": "object",
      "netCodes": "object",
      "maxRps": "string",
      "maxInstances": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
testId | **object**
testId.<br>id | **string**
testId.<br>folderId | **string**
testId.<br>name | **string**
testId.<br>description | **string**
testId.<br>labels | **object**
testId.<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>generator | **string**
testId.<br>agentInstanceId | **string**<br><p>AgentInstance ID where Test is running.</p> 
testId.<br>targetAddress | **string**<br><p>Target VM ID.</p> 
testId.<br>targetPort | **string** (int64)
testId.<br>targetVersion | **string**<br><p>Version of object under test.</p> 
testId.<br>config | **string**<br><p>Test details</p> 
testId.<br>cases[] | **string**
testId.<br>status | **string**
testId.<br>errors[] | **string**
testId.<br>favorite | **boolean** (boolean)
testId.<br>imbalancePoint | **string** (int64)
testId.<br>imbalanceTs | **string** (int64)
testId.<br>imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>imbalanceComment | **string**
testId.<br>autostops[] | **object**
testId.<br>autostops[].<br>autostopType | **string**
testId.<br>autostops[].<br>autostopCriteria | **string**
testId.<br>autostops[].<br>autostopCase | **string**
testId.<br>userId | **string**
testId.<br>testType | **string**
testId.<br>containerId | **string**
testId.<br>parts[] | **object**
testId.<br>parts[].<br>id | **string**
testId.<br>parts[].<br>folderId | **string**
testId.<br>parts[].<br>name | **string**
testId.<br>parts[].<br>description | **string**
testId.<br>parts[].<br>labels | **object**
testId.<br>parts[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>parts[].<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>parts[].<br>finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>parts[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>parts[].<br>generator | **string**
testId.<br>parts[].<br>tankInstanceId | **string**<br><p>TankInstance ID where TankJob is running.</p> 
testId.<br>parts[].<br>targetAddress | **string**<br><p>Target VM ID.</p> 
testId.<br>parts[].<br>targetPort | **string** (int64)
testId.<br>parts[].<br>targetVersion | **string**<br><p>Version of object under test.</p> 
testId.<br>parts[].<br>cases[] | **string**
testId.<br>parts[].<br>status | **string**
testId.<br>parts[].<br>errors[] | **string**
testId.<br>parts[].<br>favorite | **boolean** (boolean)
testId.<br>parts[].<br>imbalancePoint | **string** (int64)
testId.<br>parts[].<br>imbalanceTs | **string** (int64)
testId.<br>parts[].<br>imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
testId.<br>parts[].<br>jobType | **string**
testId.<br>parts[].<br>containerId | **string**
testId.<br>payloadUrls | **string** <br>`testId` includes only one of the fields `payloadUrls`, `payloadId`<br>
testId.<br>payloadId | **string** <br>`testId` includes only one of the fields `payloadUrls`, `payloadId`<br>
errors[] | **string**
results[] | **object**
results[].<br>caseName | **string**
results[].<br>quantiles | **object**
results[].<br>protoCodes | **object**
results[].<br>netCodes | **object**
results[].<br>maxRps | **string** (int64)
results[].<br>maxInstances | **string** (int64)