---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET undefined/microcosm/v1/infrastructureTemplates/{infrastructureTemplateId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
infrastructureTemplateId | Required. The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "labels": "object"
}
```

 
Field | Description
--- | ---
id | **string**<br>
name | **string**<br>
folderId | **string**<br>
labels | **object**<br>