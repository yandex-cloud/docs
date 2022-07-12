---
editable: false
---

# Method write

 

 
## HTTP request {#https-request}
```
POST undefined/logs/v1/events/{logGroupId}/{streamName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | <p>Required.</p> 
streamName | <p>Required.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "events": [
    {
      "createdAt": "string",
      "message": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
events[] | **object**<br><p>The maximum number of elements is 100.</p> 
events[].<br>createdAt | **string** (date-time)<br><p>Required. String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
events[].<br>message | **string**<br><p>The maximum string length in characters is 262144.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{}
```

 
Field | Description
--- | ---