---
editable: false
---

# Trail

## JSON Representation {#representation}
```json 
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
```
 
Field | Description
--- | ---
overall | **string** (int64)
caseId | **string**
time | **string**
reqps | **string** (int64)
resps | **string** (int64)
expect | **number** (double)
input | **string** (int64)
output | **string** (int64)
connectTime | **number** (double)
sendTime | **number** (double)
latency | **number** (double)
receiveTime | **number** (double)
threads | **string** (int64)
q50 | **number** (double)
q75 | **number** (double)
q80 | **number** (double)
q85 | **number** (double)
q90 | **number** (double)
q95 | **number** (double)
q98 | **number** (double)
q99 | **number** (double)
q100 | **number** (double)
httpCodes[] | **object**
httpCodes[].<br>code | **string** (int64)
httpCodes[].<br>count | **string** (int64)
netCodes[] | **object**
netCodes[].<br>code | **string** (int64)
netCodes[].<br>count | **string** (int64)
timeIntervals[] | **object**
timeIntervals[].<br>to | **number** (double)
timeIntervals[].<br>count | **string** (int64)

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates trail for specified job.