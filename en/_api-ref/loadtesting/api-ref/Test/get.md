---
editable: false
---

# Load Testing API, REST: Test.get
Returns test by test id.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/tests/{testId}
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
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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
imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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
parts[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
parts[].<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
parts[].<br>finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
parts[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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
parts[].<br>imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
parts[].<br>jobType | **string**
parts[].<br>containerId | **string**
payloadUrls | **string** <br> includes only one of the fields `payloadUrls`, `payloadId`<br>
payloadId | **string** <br> includes only one of the fields `payloadUrls`, `payloadId`<br>