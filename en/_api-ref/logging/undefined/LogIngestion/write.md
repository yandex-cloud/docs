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

    // `destination` includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields`destination`

  },
  "resource": {
    "type": "string",
    "id": "string"
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
destination.<br>logGroupId | **string** <br>`destination` includes only one of the fields `logGroupId`, `folderId`<br><br><p>The maximum string length in characters is 64.</p> 
destination.<br>folderId | **string** <br>`destination` includes only one of the fields `logGroupId`, `folderId`<br><br><p>The maximum string length in characters is 64.</p> 
resource | **object**<br>
resource.<br>type | **string**<br><p>Value must match the regular expression ``\|[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
resource.<br>id | **string**<br><p>Value must match the regular expression ``\|[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
entries[] | **object**<br><p>The maximum number of elements is 100.</p> 
entries[].<br>timestamp | **string** (date-time)<br><p>Required. String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>level | **string**<br>
entries[].<br>message | **string**<br><p>The maximum string length in characters is 65536.</p> 
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