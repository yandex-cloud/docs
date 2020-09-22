---
editable: false
---

# Метод listShardGroups
Возвращает список групп шардов в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params) , сервис вернет значение [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listShards#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Номер страницы. Чтобы получить следующую страницу результатов, установите значение [pageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params) равным значению поля [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listShards#responses) прошлого запроса.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "shardGroups": [
    {
      "name": "string",
      "clusterId": "string",
      "description": "string",
      "shardNames": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
shardGroups[] | **object**<br><p>Список групп шардов в кластере.</p> 
shardGroups[].<br>name | **string**<br><p>Имя группы шардов</p> 
shardGroups[].<br>clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит группа шардов.</p> 
shardGroups[].<br>description | **string**<br><p>Описание группы шардов. Длина описания должна быть от 0 до 256 символов.</p> 
shardGroups[].<br>shardNames[] | **string**<br><p>Список имен шардов, которые взоядят в группу.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-clickhouse/api-ref/Cluster/listShards#query_params">pageSize</a>, используйте <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-clickhouse/api-ref/Cluster/listShards#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> для перебора страниц результатов.</p> 