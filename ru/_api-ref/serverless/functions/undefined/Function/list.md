---
editable: false
---

# Метод list

 

 
## HTTP-запрос {#https-request}
```
GET undefined/functions/v1alpha/functions
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле.
pageSize | 
pageToken | 
filter | 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functions": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
functions[] | **object**<br>
functions[].<br>id | **string**<br>
functions[].<br>folderId | **string**<br>
functions[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
functions[].<br>name | **string**<br>
functions[].<br>description | **string**<br>
functions[].<br>labels | **object**<br>
nextPageToken | **string**<br>