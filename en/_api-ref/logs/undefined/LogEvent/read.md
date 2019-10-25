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
logGroupId | Required.
streamName | Required.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | 
pageToken | 
criteria.since | String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
criteria.until | String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
 
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
logEvents[] | **object**<br>
logEvents[].<br>logGroupId | **string**<br>
logEvents[].<br>streamName | **string**<br>
logEvents[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logEvents[].<br>message | **string**<br>
logEvents[].<br>ingestedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
logEvents[].<br>savedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br>
previousPageToken | **string**<br>