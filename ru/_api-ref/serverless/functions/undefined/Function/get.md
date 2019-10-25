---
editable: false
---

# Метод get

 

 
## HTTP-запрос {#https-request}
```
GET undefined/functions/v1alpha/functions/{functionId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
functionId | Обязательное поле.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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