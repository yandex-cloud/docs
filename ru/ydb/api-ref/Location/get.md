---
editable: false
sourcePath: en/_api-ref/ydb/v1/api-ref/Location/get.md
---

# Managed Service for YDB API, REST: Location.get
Returns the specified location.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/locations/{locationId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
locationId | <p>Required. Required. ID of the location to return.</p> 
 
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
id | **string**
description | **string**