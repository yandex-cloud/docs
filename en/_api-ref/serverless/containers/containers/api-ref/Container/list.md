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
containers[] | **object**<br>
containers[].<br>id | **string**<br>
containers[].<br>folderId | **string**<br>
containers[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
containers[].<br>name | **string**<br>
containers[].<br>description | **string**<br>
containers[].<br>labels | **object**<br>
containers[].<br>url | **string**<br>
containers[].<br>status | **string**<br>
nextPageToken | **string**<br>