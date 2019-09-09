---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET undefined/functions/v1/functions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required.
pageSize | 
pageToken | 
filter | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functions": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "logGroupId": "string",
      "httpInvokeUrl": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
functions[] | **object**<br>
functions[].<br>id | **string**<br>
functions[].<br>folderId | **string**<br>
functions[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
functions[].<br>name | **string**<br>
functions[].<br>description | **string**<br>
functions[].<br>labels | **object**<br>
functions[].<br>logGroupId | **string**<br>
functions[].<br>httpInvokeUrl | **string**<br>
functions[].<br>status | **string**<br>
nextPageToken | **string**<br>