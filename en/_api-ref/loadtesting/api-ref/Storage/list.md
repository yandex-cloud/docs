---
editable: false
---

# Method list
Retrieves the list of storages for the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v1/storages
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. The maximum string length in characters is 50.</p> 
pageSize | <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "storages": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "createdAt": "string",
      "objectStorageBucket": "string",
      "usedSize": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
storages[] | **object**
storages[].<br>id | **string**
storages[].<br>folderId | **string**
storages[].<br>name | **string**
storages[].<br>description | **string**
storages[].<br>labels | **object**
storages[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
storages[].<br>objectStorageBucket | **string**
storages[].<br>usedSize | **string** (int64)
nextPageToken | **string**