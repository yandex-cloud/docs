---
editable: false
---

# Yandex Microcosm Service, REST: Infrastructure.get

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructures/{infrastructureId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
infrastructureId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "createdAt": "string",
  "status": "string",
  "labels": "object",
  "variables": "object",
  "infrastructureTemplateId": "string"
}
```

 
Field | Description
--- | ---
id | **string**
name | **string**
folderId | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
status | **string**
labels | **object**
variables | **object**
infrastructureTemplateId | **string**