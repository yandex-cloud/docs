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
computeInstanceId | **string**
data[] | **object**
data[].<br>overall | **string** (int64)
data[].<br>caseId | **string**
data[].<br>time | **string**
data[].<br>reqps | **string** (int64)
data[].<br>resps | **string** (int64)
data[].<br>expect | **number** (double)
data[].<br>input | **string** (int64)
data[].<br>output | **string** (int64)
data[].<br>connectTime | **number** (double)
data[].<br>sendTime | **number** (double)
data[].<br>latency | **number** (double)
data[].<br>receiveTime | **number** (double)
data[].<br>threads | **string** (int64)
data[].<br>q50 | **number** (double)
data[].<br>q75 | **number** (double)
data[].<br>q80 | **number** (double)
data[].<br>q85 | **number** (double)
data[].<br>q90 | **number** (double)
data[].<br>q95 | **number** (double)
data[].<br>q98 | **number** (double)
data[].<br>q99 | **number** (double)
data[].<br>q100 | **number** (double)
data[].<br>httpCodes[] | **object**
data[].<br>httpCodes[].<br>code | **string** (int64)
data[].<br>httpCodes[].<br>count | **string** (int64)
data[].<br>netCodes[] | **object**
data[].<br>netCodes[].<br>code | **string** (int64)
data[].<br>netCodes[].<br>count | **string** (int64)
data[].<br>timeIntervals[] | **object**
data[].<br>timeIntervals[].<br>to | **number** (double)
data[].<br>timeIntervals[].<br>count | **string** (int64)
jobId | **string**
 
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
trailId | **string**
code | **string** (int64)