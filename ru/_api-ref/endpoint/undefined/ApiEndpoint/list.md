---
editable: false
---

# Метод list

 

 
## HTTP-запрос {#https-request}
```
GET undefined/endpoints
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | 
pageToken | 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "endpoints": [
    {
      "id": "string",
      "address": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
endpoints[] | **object**<br>
endpoints[].<br>id | **string**<br>
endpoints[].<br>address | **string**<br>
nextPageToken | **string**<br>