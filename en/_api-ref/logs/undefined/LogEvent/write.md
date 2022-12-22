---
editable: false
---

# Log Events Service, REST: LogEvent.write

 

 
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
events[].<br>createdAt | **string** (date-time)<br><p>Required. String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
events[].<br>message | **string**<br><p>The maximum string length in characters is 262144.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{}
```

 
Field | Description
--- | ---