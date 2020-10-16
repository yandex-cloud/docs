---
editable: false
---

# Метод list
Возвращает список доступных версий ClickHouse.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/versions
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-clickhouse/api-ref/Versions/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-clickhouse/api-ref/Versions/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-clickhouse/api-ref/Versions/list#query_params) равным значению поля [nextPageToken](/docs/managed-clickhouse/api-ref/Versions/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "version": [
    {
      "id": "string",
      "name": "string",
      "deprecated": true,
      "updatableTo": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
version[] | **object**<br><p>Список доступных версий.</p> 
version[].<br>id | **string**<br><p>Идентификатор версии.</p> 
version[].<br>name | **string**<br><p>Название версии.</p> 
version[].<br>deprecated | **boolean** (boolean)<br><p>Является ли версия устаревшей.</p> 
version[].<br>updatableTo[] | **string**<br><p>Список версий, до которых можно обновить текущую.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе, если количество результатов больше, чем <a href="/docs/managed-clickhouse/api-ref/Versions/list#query_params">pageSize</a>. Чтобы получить следующую страницу, укажите <a href="/docs/managed-clickhouse/api-ref/Versions/list#responses">nextPageToken</a> в качестве значения для <a href="/docs/managed-clickhouse/api-ref/Versions/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения <a href="/docs/managed-clickhouse/api-ref/Versions/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 