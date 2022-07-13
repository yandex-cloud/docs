---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructures
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum value is 1000.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "infrastructures": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string",
      "createdAt": "string",
      "status": "string",
      "labels": "object",
      "variables": "object",
      "infrastructureTemplateId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
infrastructures[] | **object**
infrastructures[].<br>id | **string**
infrastructures[].<br>name | **string**
infrastructures[].<br>folderId | **string**
infrastructures[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
infrastructures[].<br>status | **string**
infrastructures[].<br>labels | **object**
infrastructures[].<br>variables | **object**
infrastructures[].<br>infrastructureTemplateId | **string**
nextPageToken | **string**