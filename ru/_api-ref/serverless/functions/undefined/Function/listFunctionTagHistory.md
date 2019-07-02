---
editable: false
---

# Метод listFunctionTagHistory

 

 
## HTTP-запрос {#https-request}
```
GET undefined/functions/v1alpha/functions/{functionId}:tagHistory
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
functionId | Обязательное поле.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
tag | Значение должно соответствовать регулярному выражению `` [a-z][-_0-9a-z]*|[$]latest ``.
pageSize | Допустимые значения — от 0 до 1000 включительно.
pageToken | Максимальная длина строки в символах — 100.
filter | Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functionTagHistoryRecord": [
    {
      "functionId": "string",
      "functionVersionId": "string",
      "tag": "string",
      "effectiveFrom": "string",
      "effectiveTo": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
functionTagHistoryRecord[] | **object**<br>
functionTagHistoryRecord[].<br>functionId | **string**<br>
functionTagHistoryRecord[].<br>functionVersionId | **string**<br>
functionTagHistoryRecord[].<br>tag | **string**<br>
functionTagHistoryRecord[].<br>effectiveFrom | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
functionTagHistoryRecord[].<br>effectiveTo | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
nextPageToken | **string**<br>