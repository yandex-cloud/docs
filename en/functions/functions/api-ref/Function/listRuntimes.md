---
editable: false
---

# Метод listRuntimes
Список доступных сред выполнения для указанной функции.
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/runtimes
```
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "runtimes": [
    "string"
  ]
}
```

 
Поле | Описание
--- | ---
runtimes[] | **string**<br><p>Среды выполнения, доступные для указанной функции.</p> 