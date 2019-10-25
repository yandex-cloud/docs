---
editable: false
---

# Метод listResources

 

 
## HTTP-запрос {#https-request}
```
GET undefined/microcosm/v1/infrastructures/{infrastructureId}/resources
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
infrastructureId | Обязательное поле. Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное значение — 1000.
pageToken | Максимальная длина строки в символах — 100.
filter | Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resources": [
    {
      "infrastructureId": "string",
      "deploymentId": "string",
      "deploymentNumber": "string",
      "resourceSpecName": "string",
      "resourceId": "string",
      "type": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
resources[] | **object**<br>
resources[].<br>infrastructureId | **string**<br>
resources[].<br>deploymentId | **string**<br>
resources[].<br>deploymentNumber | **string**<br>
resources[].<br>resourceSpecName | **string**<br>
resources[].<br>resourceId | **string**<br>
resources[].<br>type | **string**<br>
resources[].<br>status | **string**<br>
nextPageToken | **string**<br>