---
editable: false
---

# Method write

 

 
## HTTP request {#https-request}
```
POST undefined/logging/v1/write
```
 
## Body parameters {#body_params}
 
```json 
{
  "destination": {
    "logGroupId": "string",
    "folderId": "string"
  },
  "entries": [
    {
      "timestamp": "string",
      "level": "string",
      "message": "string",
      "jsonPayload": "object"
    }
  ]
}
```

 
Field | Description
--- | ---
destination | **object**<br><p>Required.</p> 
destination.<br>logGroupId | **string**<br>
destination.<br>folderId | **string**<br>
entries[] | **object**<br><p>The maximum number of elements is 100.</p> 
entries[].<br>timestamp | **string** (date-time)<br><p>Required. String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>level | **string**<br>
entries[].<br>message | **string**<br><p>The maximum string length in characters is 262144.</p> 
entries[].<br>jsonPayload | **object**<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "errors": "object"
}
```

 
Field | Description
--- | ---
errors | **object**<br>