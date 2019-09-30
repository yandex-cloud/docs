---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET undefined/iot-devices/v1/registries
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. The maximum string length in characters is 50.
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "logGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
registries[] | **object**<br>
registries[].<br>id | **string**<br>
registries[].<br>folderId | **string**<br>
registries[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
registries[].<br>name | **string**<br>
registries[].<br>description | **string**<br>
registries[].<br>labels | **object**<br>
registries[].<br>status | **string**<br>
registries[].<br>logGroupId | **string**<br>
nextPageToken | **string**<br>