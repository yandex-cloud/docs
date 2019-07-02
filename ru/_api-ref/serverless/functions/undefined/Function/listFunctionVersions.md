---
editable: false
---

# Метод listFunctionVersions

 

 
## HTTP-запрос {#https-request}
```
GET undefined/functions/v1alpha/versions
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | 
functionId | 
pageSize | Допустимые значения — от 0 до 1000 включительно.
pageToken | Максимальная длина строки в символах — 100.
filter | Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
    {
      "id": "string",
      "functionId": "string",
      "description": "string",
      "createdAt": "string",
      "runtime": "string",
      "entrypoint": "string",
      "resources": {
        "memory": "string"
      },
      "executionTimeout": "string",
      "imageSize": "string",
      "status": "string",
      "tags": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
versions[] | **object**<br>
versions[].<br>id | **string**<br>
versions[].<br>functionId | **string**<br>
versions[].<br>description | **string**<br>
versions[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
versions[].<br>runtime | **string**<br>
versions[].<br>entrypoint | **string**<br>
versions[].<br>resources | **object**<br>
versions[].<br>resources.<br>memory | **string** (int64)<br><p>Допустимые значения — от 33554432 до 1073741824 включительно.</p> 
versions[].<br>executionTimeout | **string**<br>
versions[].<br>imageSize | **string** (int64)<br>
versions[].<br>status | **string**<br>
versions[].<br>tags[] | **string**<br>
nextPageToken | **string**<br>