---
editable: false
---

# Метод get

 

 
## HTTP-запрос {#https-request}
```
GET undefined/microcosm/v1/infrastructures/{infrastructureId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
infrastructureId | Обязательное поле. Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
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