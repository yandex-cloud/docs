---
editable: false
---

# Method listResources

 

 
## HTTP request {#https-request}
```
GET undefined/logging/v1/logGroups/{logGroupId}:listResources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | Required. The maximum string length in characters is 64.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
type | The maximum string length in characters is 256.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resources": [
    {
      "type": "string",
      "ids": [
        "string"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
resources[] | **object**<br>
resources[].<br>type | **string**<br>
resources[].<br>ids[] | **string**<br>