---
editable: false
sourcePath: en/_api-ref/ydb/api-ref/Location/get.md
---

# Method get
Returns the specified location.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/locations/{locationId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
locationId | Required. Required. ID of the location to return.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br>
description | **string**<br>