---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET undefined/functions/v1/functions/{functionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | Required.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "logGroupId": "string",
  "httpInvokeUrl": "string",
  "status": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
labels | **object**<br>
logGroupId | **string**<br>
httpInvokeUrl | **string**<br>
status | **string**<br>