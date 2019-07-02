---
editable: false
---

# Метод list

 

 
## HTTP-запрос {#https-request}
```
GET undefined/microcosm/v1/infrastructureTemplates
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Максимальная длина строки в символах — 50.
pageSize | Максимальное значение — 1000.
pageToken | Максимальная длина строки в символах — 100.
filter | Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "infrastructureTemplates": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
infrastructureTemplates[] | **object**<br>
infrastructureTemplates[].<br>id | **string**<br>
infrastructureTemplates[].<br>name | **string**<br>
infrastructureTemplates[].<br>folderId | **string**<br>
infrastructureTemplates[].<br>labels | **object**<br>
nextPageToken | **string**<br>