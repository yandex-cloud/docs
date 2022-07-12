---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructureTemplates
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
  "infrastructureTemplates": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
infrastructureTemplates[] | **object**<br>
infrastructureTemplates[].<br>id | **string**<br>
infrastructureTemplates[].<br>name | **string**<br>
infrastructureTemplates[].<br>folderId | **string**<br>
infrastructureTemplates[].<br>labels | **object**<br>
nextPageToken | **string**<br>