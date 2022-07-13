---
editable: false
---

# Infrastructure

## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new, empty [Infrastructure](/Infrastructure#representation).
[delete](delete.md) | Deletes an EMPTY [Infrastructure](/Infrastructure#representation).
[get](get.md) | 
[list](list.md) | 
[listDeployments](listDeployments.md) | 
[listOperations](listOperations.md) | 
[listResources](listResources.md) | 
[update](update.md) | Update [Infrastructure](/Infrastructure#representation).