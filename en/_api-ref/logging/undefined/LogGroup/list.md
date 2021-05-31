---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET undefined/logging/v1/logGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. The maximum string length in characters is 64.
pageSize | 
pageToken | The maximum string length in characters is 100.
filter | supported fields for filter: name  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "groups": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "retentionPeriod": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
groups[] | **object**<br>
groups[].<br>id | **string**<br>
groups[].<br>folderId | **string**<br>
groups[].<br>cloudId | **string**<br>
groups[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
groups[].<br>name | **string**<br>
groups[].<br>description | **string**<br>
groups[].<br>labels | **object**<br>
groups[].<br>status | **string**<br>
groups[].<br>retentionPeriod | **string**<br>
nextPageToken | **string**<br>