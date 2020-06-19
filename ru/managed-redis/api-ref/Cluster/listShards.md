---
editable: false
---

# Метод listShards
Получает список шардов.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}/shards
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера redis, для которого нужно вывести список шардов. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-redis/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-redis/api-ref/Cluster/listShards#query_params) , сервис вернет значение [nextPageToken](/docs/managed-redis/api-ref/Cluster/listShards#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-redis/api-ref/Cluster/listShards#query_params) равным значению поля [nextPageToken](/docs/managed-redis/api-ref/Cluster/listShards#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "shards": [
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
shards[] | **object**<br><p>Список шардов Redis.</p> 
shards[].<br>name | **string**<br><p>Имя шарда Redis. Имя шарда назначается пользователем при создании и не может быть изменено. Длина 1-63 символов.</p> 
shards[].<br>clusterId | **string**<br><p>Идентификатор кластера Redis, к которому принадлежит шард. Этот идентификатор генерирует MDB при создании.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-redis/api-ref/Cluster/listShards#query_params">pageSize</a>, используйте <a href="/docs/managed-redis/api-ref/Cluster/listShards#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-redis/api-ref/Cluster/listShards#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-redis/api-ref/Cluster/listShards#responses">nextPageToken</a> для перебора страниц результатов.</p> 