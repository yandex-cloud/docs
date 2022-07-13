---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/containers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required.</p> 
pageSize | 
pageToken | 
filter | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "containers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "url": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
containers[] | **object**
containers[].<br>id | **string**
containers[].<br>folderId | **string**
containers[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
containers[].<br>name | **string**
containers[].<br>description | **string**
containers[].<br>labels | **object**
containers[].<br>url | **string**
containers[].<br>status | **string**
nextPageToken | **string**