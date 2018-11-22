# Метод listLogs
Получает логи для указанного кластера MongoDB.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Обязательное поле. Идентификатор кластера MongoDB, для которого следует запросить логи. Чтобы получить идентификатор кластера MongoDB, используйте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы из таблицы логов для запроса. Если столбцы не указаны, записи логов возвращаются целиком.
serviceType | Тип сервиса, для которого следует запросить логи.
fromTime | Начало периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Конец периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/Cluster/listLogs#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/listLogs#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/mongodb/Cluster/listLogs#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/listLogs#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
logs | **object**<br><p>Запрошенные записи логов.</p> 
logs.<br>timestamp | **string** (date-time)<br><p>Время создания записи в журнале, в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logs.<br>message | **object**<br><p>Содержание записи журнала.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/mongodb/Cluster/listLogs#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/mongodb/Cluster/listLogs#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/mongodb/Cluster/listLogs#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/mongodb/Cluster/listLogs#responses">nextPageToken</a> для перебора страниц результатов.</p> 