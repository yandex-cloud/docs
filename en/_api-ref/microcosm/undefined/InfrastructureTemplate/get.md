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
infrastructureTemplateId | <p>Required. The maximum string length in characters is 50.</p> 
 
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
id | **string**
name | **string**
folderId | **string**
labels | **object**