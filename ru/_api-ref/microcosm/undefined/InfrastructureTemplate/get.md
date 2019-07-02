---
editable: false
---

# Метод get

 

 
## HTTP-запрос {#https-request}
```
GET undefined/microcosm/v1/infrastructureTemplates/{infrastructureTemplateId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
infrastructureTemplateId | Обязательное поле. Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "labels": "object"
}
```

 
Поле | Описание
--- | ---
id | **string**<br>
name | **string**<br>
folderId | **string**<br>
labels | **object**<br>