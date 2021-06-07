---
editable: false
---

# Метод listLogs
Получает логи для указанного кластера ClickHouse.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, для которого следует запросить логи. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [list](/docs/managed-clickhouse/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы из таблицы логов, которые нужно запросить. Если столбцы не указаны, записи логов возвращаются целиком.
serviceType | Тип сервиса, для которого следует запросить логи.<ul> <li>CLICKHOUSE: Логи работы ClickHouse.</li> </ul> 
fromTime | Начало периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Конец периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем [pageSize](/docs/managed-clickhouse/api-ref/Cluster/listLogs#query_params), сервис вернет значение [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-clickhouse/api-ref/Cluster/listLogs#query_params) равным значению поля [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logs": [
    {
      "timestamp": "string",
      "message": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
logs[] | **object**<br><p>Запрошенные записи в логе.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Отметка времени для записи журнала в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> текстовом формате.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logs[].<br>message | **object**<br><p>Содержимое записи в логе.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#query_params">pageSize</a>, используйте <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses">nextPageToken</a> для перебора страниц результатов. Это значение взаимозаменяемо с ``nextRecordToken`` из метода StreamLogs.</p> 