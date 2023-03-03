---
editable: false
---

# Load Testing API, REST: Test.list
Retrieves the list of tests for the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/tests
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
  "tests": [
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

      // `tests[]` includes only one of the fields `payloadUrls`, `payloadId`
      "payloadUrls": "string",
      "payloadId": "string",
      // end of the list of possible fields`tests[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**
tests[] | **object**
tests[].<br>id | **string**
tests[].<br>folderId | **string**
tests[].<br>name | **string**
tests[].<br>description | **string**
tests[].<br>labels | **object**
tests[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>generator | **string**
tests[].<br>agentInstanceId | **string**<br><p>AgentInstance ID where Test is running.</p> 
tests[].<br>targetAddress | **string**<br><p>Target VM ID.</p> 
tests[].<br>targetPort | **string** (int64)
tests[].<br>targetVersion | **string**<br><p>Version of object under test.</p> 
tests[].<br>config | **string**<br><p>Test details</p> 
tests[].<br>cases[] | **string**
tests[].<br>status | **string**
tests[].<br>errors[] | **string**
tests[].<br>favorite | **boolean** (boolean)
tests[].<br>imbalancePoint | **string** (int64)
tests[].<br>imbalanceTs | **string** (int64)
tests[].<br>imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>imbalanceComment | **string**
tests[].<br>autostops[] | **object**
tests[].<br>autostops[].<br>autostopType | **string**
tests[].<br>autostops[].<br>autostopCriteria | **string**
tests[].<br>autostops[].<br>autostopCase | **string**
tests[].<br>userId | **string**
tests[].<br>testType | **string**
tests[].<br>containerId | **string**
tests[].<br>parts[] | **object**
tests[].<br>parts[].<br>id | **string**
tests[].<br>parts[].<br>folderId | **string**
tests[].<br>parts[].<br>name | **string**
tests[].<br>parts[].<br>description | **string**
tests[].<br>parts[].<br>labels | **object**
tests[].<br>parts[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>parts[].<br>startedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>parts[].<br>finishedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>parts[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>parts[].<br>generator | **string**
tests[].<br>parts[].<br>tankInstanceId | **string**<br><p>TankInstance ID where TankJob is running.</p> 
tests[].<br>parts[].<br>targetAddress | **string**<br><p>Target VM ID.</p> 
tests[].<br>parts[].<br>targetPort | **string** (int64)
tests[].<br>parts[].<br>targetVersion | **string**<br><p>Version of object under test.</p> 
tests[].<br>parts[].<br>cases[] | **string**
tests[].<br>parts[].<br>status | **string**
tests[].<br>parts[].<br>errors[] | **string**
tests[].<br>parts[].<br>favorite | **boolean** (boolean)
tests[].<br>parts[].<br>imbalancePoint | **string** (int64)
tests[].<br>parts[].<br>imbalanceTs | **string** (int64)
tests[].<br>parts[].<br>imbalanceAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
tests[].<br>parts[].<br>jobType | **string**
tests[].<br>parts[].<br>containerId | **string**
tests[].<br>payloadUrls | **string** <br>`tests[]` includes only one of the fields `payloadUrls`, `payloadId`<br>
tests[].<br>payloadId | **string** <br>`tests[]` includes only one of the fields `payloadUrls`, `payloadId`<br>
nextPageToken | **string**