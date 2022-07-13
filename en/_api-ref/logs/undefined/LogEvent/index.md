---
editable: false
---

# LogEvent

## JSON Representation {#representation}
```json 
{
  "logGroupId": "string",
  "streamName": "string",
  "createdAt": "string",
  "message": "string",
  "ingestedAt": "string",
  "savedAt": "string"
}
```
 
Field | Description
--- | ---
logGroupId | **string**
streamName | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
message | **string**
ingestedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
savedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[read](read.md) | 
[write](write.md) | 