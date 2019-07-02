---
editable: false
---

# Метод list

 

 
## HTTP-запрос {#https-request}
```
GET undefined/microcosm/v1/infrastructures
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
  "infrastructures": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
infrastructures[] | **object**<br>
infrastructures[].<br>id | **string**<br>
infrastructures[].<br>name | **string**<br>
infrastructures[].<br>folderId | **string**<br>
infrastructures[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
infrastructures[].<br>status | **string**<br>
infrastructures[].<br>labels | **object**<br>
infrastructures[].<br>variables | **object**<br>
infrastructures[].<br>infrastructureTemplateId | **string**<br>
nextPageToken | **string**<br>