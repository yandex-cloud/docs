---
editable: false
---

# Method get
Returns test by test id.
 

 
## HTTP request {#https-request}
```
GET undefined/loadtesting/agent/v1/tests/{testId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
testId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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

  //  includes only one of the fields `ammoUrls`, `ammoId`
  "ammoUrls": "string",
  "ammoId": "string",
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
targetAddress | **string**<br><p>Target VM.</p> 
targetPort | **string** (int64)
targetVersion | **string**<br><p>Version of object under test.</p> 
config | **string**<br><p>Test details</p> 
cases[] | **string**
status | **string**
errors[] | **string**
favorite | **boolean** (boolean)
ammoUrls | **string** <br> includes only one of the fields `ammoUrls`, `ammoId`<br>
ammoId | **string** <br> includes only one of the fields `ammoUrls`, `ammoId`<br>