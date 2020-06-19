---
editable: false
---

# Метод list
Возвращает список доступных ресурсов Role.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/roles
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/Role/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/Role/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/Role/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/Role/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "roles": [
    {
      "id": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
roles[] | **object**<br><p>Ресурс Role. Подробнее см. в разделе <a href="/docs/iam/concepts/access-control/roles">Роли</a>.</p> 
roles[].<br>id | **string**<br><p>Идентификатор роли.</p> 
roles[].<br>description | **string**<br><p>Описание роли. Длина описания должна быть от 0 до 256 символов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/iam/api-ref/Role/list#query_params">pageSize</a>, используйте <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/iam/api-ref/Role/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 