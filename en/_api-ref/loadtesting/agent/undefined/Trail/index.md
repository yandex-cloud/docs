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
overall | **string** (int64)<br>
caseId | **string**<br>
time | **string**<br>
reqps | **string** (int64)<br>
resps | **string** (int64)<br>
expect | **number** (double)<br>
input | **string** (int64)<br>
output | **string** (int64)<br>
connectTime | **number** (double)<br>
sendTime | **number** (double)<br>
latency | **number** (double)<br>
receiveTime | **number** (double)<br>
threads | **string** (int64)<br>
q50 | **number** (double)<br>
q75 | **number** (double)<br>
q80 | **number** (double)<br>
q85 | **number** (double)<br>
q90 | **number** (double)<br>
q95 | **number** (double)<br>
q98 | **number** (double)<br>
q99 | **number** (double)<br>
q100 | **number** (double)<br>
httpCodes[] | **object**<br>
httpCodes[].<br>code | **string** (int64)<br>
httpCodes[].<br>count | **string** (int64)<br>
netCodes[] | **object**<br>
netCodes[].<br>code | **string** (int64)<br>
netCodes[].<br>count | **string** (int64)<br>
timeIntervals[] | **object**<br>
timeIntervals[].<br>to | **number** (double)<br>
timeIntervals[].<br>count | **string** (int64)<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates trail for specified job.