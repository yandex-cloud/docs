---
editable: false
---

# Метод list
Получает список ресурсов Database для указанного кластера MongoDB.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/databases
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MongoDB, для которого следует вернуть список баз данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mongodb/api-ref/Database/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-mongodb/api-ref/Database/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mongodb/api-ref/Database/list#query_params) равным значению поля [nextPageToken](/docs/managed-mongodb/api-ref/Database/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
databases[] | **object**<br><p>Ресурс Database для MongoDB. Подробнее см. в разделе <a href="/docs/managed-mongodb/concepts">Developer's Guide</a>.</p> 
databases[].<br>name | **string**<br><p>Имя базы данных.</p> 
databases[].<br>clusterId | **string**<br><p>Идентификатор кластера MongoDB, к которому принадлежит база данных.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mongodb/api-ref/Database/list#query_params">pageSize</a>, используйте <a href="/docs/managed-mongodb/api-ref/Database/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mongodb/api-ref/Database/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mongodb/api-ref/Database/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 