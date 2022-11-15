---
editable: false
---

# Test

## JSON Representation {#representation}
```json 
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

  //  includes only one of the fields `payloadUrls`, `payloadId`
  "payloadUrls": "string",
  "payloadId": "string",
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**
folderId | **string**
name | **string**
description | **string**
labels | **object**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
generator | **string**
agentInstanceId | **string**<br><p>AgentInstance ID where Test is running.</p> 
targetAddress | **string**<br><p>Target VM ID.</p> 
targetPort | **string** (int64)
targetVersion | **string**<br><p>Version of object under test.</p> 
config | **string**<br><p>Test details</p> 
cases[] | **string**
status | **string**
errors[] | **string**
favorite | **boolean** (boolean)
imbalancePoint | **string** (int64)
imbalanceTs | **string** (int64)
imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
imbalanceComment | **string**
autostops[] | **object**
autostops[].<br>autostopType | **string**
autostops[].<br>autostopCriteria | **string**
autostops[].<br>autostopCase | **string**
userId | **string**
testType | **string**
containerId | **string**
parts[] | **object**
parts[].<br>id | **string**
parts[].<br>folderId | **string**
parts[].<br>name | **string**
parts[].<br>description | **string**
parts[].<br>labels | **object**
parts[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
parts[].<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
parts[].<br>finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
parts[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
parts[].<br>generator | **string**
parts[].<br>tankInstanceId | **string**<br><p>TankInstance ID where TankJob is running.</p> 
parts[].<br>targetAddress | **string**<br><p>Target VM ID.</p> 
parts[].<br>targetPort | **string** (int64)
parts[].<br>targetVersion | **string**<br><p>Version of object under test.</p> 
parts[].<br>cases[] | **string**
parts[].<br>status | **string**
parts[].<br>errors[] | **string**
parts[].<br>favorite | **boolean** (boolean)
parts[].<br>imbalancePoint | **string** (int64)
parts[].<br>imbalanceTs | **string** (int64)
parts[].<br>imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
parts[].<br>jobType | **string**
parts[].<br>containerId | **string**
payloadUrls | **string** <br> includes only one of the fields `payloadUrls`, `payloadId`<br>
payloadId | **string** <br> includes only one of the fields `payloadUrls`, `payloadId`<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a test in the specified folder.
[createMulti](createMulti.md) | Creates a multitest in the specified folder.
[delete](delete.md) | Deletes the specified test
[get](get.md) | Returns test by test id.
[getMonitoringHosts](getMonitoringHosts.md) | 
[getMonitoringReport](getMonitoringReport.md) | 
[getSummary](getSummary.md) | 
[list](list.md) | Retrieves the list of tests for the specified folder.
[stop](stop.md) | Stops the specified test.
[update](update.md) | Updates the specified test.
[validateConfig](validateConfig.md) | 