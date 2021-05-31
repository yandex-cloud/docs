---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET undefined/logging/v1/logGroups/{logGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | Required. The maximum string length in characters is 64.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "retentionPeriod": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
cloudId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
labels | **object**<br>
status | **string**<br>
retentionPeriod | **string**<br>