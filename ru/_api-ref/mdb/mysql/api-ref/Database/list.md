---
editable: false
---

# Метод list
Получает список баз данных MySQL в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/databases
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MySQL, для которого нужно вывести список баз данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mysql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mysql/api-ref/Database/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-mysql/api-ref/Database/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mysql/api-ref/Database/list#query_params) равным значению поля [nextPageToken](/docs/managed-mysql/api-ref/Database/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
databases[] | **object**<br><p>База данных MySQL. Подробнее см. в <a href="/docs/managed-mysql/concepts">документации</a>.</p> 
databases[].<br>name | **string**<br><p>Имя базы данных.</p> 
databases[].<br>clusterId | **string**<br><p>Идентификатор кластера MySQL, которому принадлежит база данных.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageSize</a>, используйте <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mysql/api-ref/Database/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mysql/api-ref/Database/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 