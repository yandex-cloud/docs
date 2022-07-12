---
editable: false
---

# Method get
Returns the specified storage.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v1/storages/{storageId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
storageId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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
```

 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
name | **string**<br>
description | **string**<br>
labels | **object**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
objectStorageBucket | **string**<br>
usedSize | **string** (int64)<br>