---
editable: false
---

# Method read

 

 
## HTTP request {#https-request}
```
GET undefined/logging/v1/read
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageToken | 
criteria.logGroupId | Required.
criteria.resourceType | The maximum string length in characters is 63.
criteria.resourceId | The maximum string length in characters is 63.
criteria.since | String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
criteria.until | String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
criteria.levels | 
criteria.filter | 
criteria.pageSize | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logGroupId": "string",
  "entries": [
    {
      "uid": "string",
      "resource": {
        "type": "string",
        "id": "string"
      },
      "timestamp": "string",
      "ingestedAt": "string",
      "savedAt": "string",
      "level": "string",
      "message": "string",
      "jsonPayload": "object"
    }
  ],
  "nextPageToken": "string",
  "previousPageToken": "string"
}
```

 
Field | Description
--- | ---
logGroupId | **string**<br>
entries[] | **object**<br>
entries[].<br>uid | **string**<br>
entries[].<br>resource | **object**<br>
entries[].<br>resource.<br>type | **string**<br>
entries[].<br>resource.<br>id | **string**<br>
entries[].<br>timestamp | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>ingestedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>savedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>level | **string**<br>
entries[].<br>message | **string**<br>
entries[].<br>jsonPayload | **object**<br>
nextPageToken | **string**<br>
previousPageToken | **string**<br>