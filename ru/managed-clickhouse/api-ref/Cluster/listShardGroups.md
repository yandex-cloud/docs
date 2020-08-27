---
editable: false
---

# Метод listShardGroups
Получает список групп шардов, принадлежащих указанному кластеру.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, к которому принадлежит группа шардов.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем [pageSize](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params), сервис вернет значение [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params) равным значению поля [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
shardGroups[] | **object**<br><p>Список групп шардов кластера ClickHouse.</p> 
shardGroups[].<br>name | **string**<br><p>Имя группы шардов.</p> 
shardGroups[].<br>clusterId | **string**<br><p>Идентификатор кластера, к которому принадлежит группа шардов.</p> 
shardGroups[].<br>description | **string**<br><p>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов.</p> 
shardGroups[].<br>shardNames[] | **string**<br><p>Список имен шардов, содержащихся в группе шардов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageSize</a>, используйте <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> для перебора страниц результатов.</p> 