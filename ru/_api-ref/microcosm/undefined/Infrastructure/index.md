---
editable: false
---

# Infrastructure

## JSON-представление {#representation}
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
 
Поле | Описание
--- | ---
id | **string**<br>
name | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
status | **string**<br>
labels | **object**<br>
variables | **object**<br>
infrastructureTemplateId | **string**<br>

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Creates a new, empty [Infrastructure](/Infrastructure#representation).
[delete](delete.md) | Deletes an EMPTY [Infrastructure](/Infrastructure#representation).
[get](get.md) | 
[list](list.md) | 
[listDeployments](listDeployments.md) | 
[listOperations](listOperations.md) | 
[listResources](listResources.md) | 
[update](update.md) | Update [Infrastructure](/Infrastructure#representation).