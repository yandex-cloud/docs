---
editable: false
---

# Endpoints, REST: ApiEndpoint.list

 

 
## HTTP request {#https-request}
```
GET undefined/endpoints
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | 
pageToken | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "endpoints": [
    {
      "id": "string",
      "address": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
endpoints[] | **object**
endpoints[].<br>id | **string**
endpoints[].<br>address | **string**
nextPageToken | **string**