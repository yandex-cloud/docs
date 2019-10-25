---
editable: false
---

# Function

## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object"
}
```
 
Поле | Описание
--- | ---
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br>
description | **string**<br>
labels | **object**<br>

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | 
[createFunctionVersion](createFunctionVersion.md) | 
[delete](delete.md) | 
[get](get.md) | 
[getFunctionVersion](getFunctionVersion.md) | 
[getFunctionVersionByTag](getFunctionVersionByTag.md) | 
[list](list.md) | 
[listFunctionTagHistory](listFunctionTagHistory.md) | 
[listFunctionVersions](listFunctionVersions.md) | 
[listOperations](listOperations.md) | 
[listRuntimes](listRuntimes.md) | 
[removeTag](removeTag.md) | 
[setTag](setTag.md) | 
[update](update.md) | 