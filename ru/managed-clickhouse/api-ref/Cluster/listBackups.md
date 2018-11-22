# Метод listBackups
Получает список доступных резервных копий для указанного
кластера ClickHouse.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/backups
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [list](/docs/mdb/api-ref/clickhouse/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/clickhouse/Cluster/listBackups#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listBackups#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/clickhouse/Cluster/listBackups#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listBackups#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
backups | **object**<br><p>Ресурс Backup для ClickHouse. Подробное описание см. в <a href="/docs/mdb/concepts">документации MDB</a>.</p> 
backups.<br>id | **string**<br><p>Идентификатор резервной копии.</p> 
backups.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
backups.<br>createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> 
backups.<br>sourceClusterId | **string**<br><p>Идентификатор кластера ClickHouse, для которого была создана резервная копия.</p> 
backups.<br>startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/clickhouse/Cluster/listBackups#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/clickhouse/Cluster/listBackups#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/clickhouse/Cluster/listBackups#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/clickhouse/Cluster/listBackups#responses">nextPageToken</a> для перебора страниц результатов.</p> 