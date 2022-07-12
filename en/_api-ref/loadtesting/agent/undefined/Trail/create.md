---
editable: false
---

# Method create
Creates trail for specified job.
 

 
## HTTP request {#https-request}
```
POST undefined/loadtesting/agent/v1/trails
```
 
## Body parameters {#body_params}
 
```json 
{
  "computeInstanceId": "string",
  "data": [
    {
      "overall": "string",
      "caseId": "string",
      "time": "string",
      "reqps": "string",
      "resps": "string",
      "expect": "number",
      "input": "string",
      "output": "string",
      "connectTime": "number",
      "sendTime": "number",
      "latency": "number",
      "receiveTime": "number",
      "threads": "string",
      "q50": "number",
      "q75": "number",
      "q80": "number",
      "q85": "number",
      "q90": "number",
      "q95": "number",
      "q98": "number",
      "q99": "number",
      "q100": "number",
      "httpCodes": [
        {
          "code": "string",
          "count": "string"
        }
      ],
      "netCodes": [
        {
          "code": "string",
          "count": "string"
        }
      ],
      "timeIntervals": [
        {
          "to": "number",
          "count": "string"
        }
      ]
    }
  ],
  "jobId": "string"
}
```

 
Field | Description
--- | ---
computeInstanceId | **string**<br>
data[] | **object**<br>
data[].<br>overall | **string** (int64)<br>
data[].<br>caseId | **string**<br>
data[].<br>time | **string**<br>
data[].<br>reqps | **string** (int64)<br>
data[].<br>resps | **string** (int64)<br>
data[].<br>expect | **number** (double)<br>
data[].<br>input | **string** (int64)<br>
data[].<br>output | **string** (int64)<br>
data[].<br>connectTime | **number** (double)<br>
data[].<br>sendTime | **number** (double)<br>
data[].<br>latency | **number** (double)<br>
data[].<br>receiveTime | **number** (double)<br>
data[].<br>threads | **string** (int64)<br>
data[].<br>q50 | **number** (double)<br>
data[].<br>q75 | **number** (double)<br>
data[].<br>q80 | **number** (double)<br>
data[].<br>q85 | **number** (double)<br>
data[].<br>q90 | **number** (double)<br>
data[].<br>q95 | **number** (double)<br>
data[].<br>q98 | **number** (double)<br>
data[].<br>q99 | **number** (double)<br>
data[].<br>q100 | **number** (double)<br>
data[].<br>httpCodes[] | **object**<br>
data[].<br>httpCodes[].<br>code | **string** (int64)<br>
data[].<br>httpCodes[].<br>count | **string** (int64)<br>
data[].<br>netCodes[] | **object**<br>
data[].<br>netCodes[].<br>code | **string** (int64)<br>
data[].<br>netCodes[].<br>count | **string** (int64)<br>
data[].<br>timeIntervals[] | **object**<br>
data[].<br>timeIntervals[].<br>to | **number** (double)<br>
data[].<br>timeIntervals[].<br>count | **string** (int64)<br>
jobId | **string**<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "trailId": "string",
  "code": "string"
}
```

 
Field | Description
--- | ---
trailId | **string**<br>
code | **string** (int64)<br>