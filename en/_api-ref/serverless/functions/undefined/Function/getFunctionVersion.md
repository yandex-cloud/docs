---
editable: false
---

# Method getFunctionVersion
Deprecated. Use GetVersion.
 

 
## HTTP request {#https-request}
```
GET undefined/functions/v1/versions/{functionVersionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionVersionId | Required.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "functionId": "string",
  "description": "string",
  "createdAt": "string",
  "runtime": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "imageSize": "string",
  "status": "string",
  "tags": [
    "string"
  ],
  "logGroupId": "string",
  "environment": "object"
}
```

 
Field | Description
--- | ---
id | **string**<br>
functionId | **string**<br>
description | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
runtime | **string**<br>
entrypoint | **string**<br>
resources | **object**<br>
resources.<br>memory | **string** (int64)<br><p>Acceptable values are 33554432 to 1073741824, inclusive.</p> 
executionTimeout | **string**<br>
serviceAccountId | **string**<br>
imageSize | **string** (int64)<br>
status | **string**<br>
tags[] | **string**<br>
logGroupId | **string**<br>
environment | **object**<br>