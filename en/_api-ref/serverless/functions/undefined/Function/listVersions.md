---
editable: false
---

# Method listVersions

 

 
## HTTP request {#https-request}
```
GET undefined/functions/v1/versions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
functionId | 
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
filter | The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
    {
      "id": "string",
      "functionId": "string",
      "description": "string",
      "createdAt": "string",
      "runtime": "string",
      "entrypoint": "string",
      "resources": {
        "memory": "string"
      },
      "executionTimeout": "string",
      "serviceAccountId": "string",
      "imageSize": "string",
      "status": "string",
      "tags": [
        "string"
      ],
      "logGroupId": "string",
      "environment": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
versions[] | **object**<br>
versions[].<br>id | **string**<br>
versions[].<br>functionId | **string**<br>
versions[].<br>description | **string**<br>
versions[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
versions[].<br>runtime | **string**<br>
versions[].<br>entrypoint | **string**<br>
versions[].<br>resources | **object**<br>
versions[].<br>resources.<br>memory | **string** (int64)<br><p>Acceptable values are 33554432 to 1073741824, inclusive.</p> 
versions[].<br>executionTimeout | **string**<br>
versions[].<br>serviceAccountId | **string**<br>
versions[].<br>imageSize | **string** (int64)<br>
versions[].<br>status | **string**<br>
versions[].<br>tags[] | **string**<br>
versions[].<br>logGroupId | **string**<br>
versions[].<br>environment | **object**<br>
nextPageToken | **string**<br>