---
editable: false
---

# Method read

 

 
## HTTP request {#https-request}
```
GET undefined/logs/v1/events/{logGroupId}/{streamName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | <p>Required.</p> 
streamName | <p>Required.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | 
pageToken | 
criteria.since | <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
criteria.until | <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logEvents": [
    {
      "logGroupId": "string",
      "streamName": "string",
      "createdAt": "string",
      "message": "string",
      "ingestedAt": "string",
      "savedAt": "string"
    }
  ],
  "nextPageToken": "string",
  "previousPageToken": "string"
}
```

 
Field | Description
--- | ---
logEvents[] | **object**
logEvents[].<br>logGroupId | **string**
logEvents[].<br>streamName | **string**
logEvents[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logEvents[].<br>message | **string**
logEvents[].<br>ingestedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logEvents[].<br>savedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**
previousPageToken | **string**