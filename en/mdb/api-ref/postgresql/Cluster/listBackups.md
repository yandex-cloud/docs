# Метод listBackups
Получает список доступных резервных копий для указанного
кластера PostgreSQL.
 

 
## HTTP-запрос
`GET /managed-postgresql/v1/clusters/{clusterId}/backups`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/Cluster/listBackups#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listBackups#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/postgresql/Cluster/listBackups#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listBackups#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
backups | **object**<br><p>Ресурс Backup для PostgreSQL. Подробнее см. в разделе <a href="/docs/mdb/concepts">Взаимосвязь ресурсов сервиса</a>.</p> 
backups.<br>id | **string**<br><p>Идентификатор резервной копии.</p> 
backups.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
backups.<br>createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> 
backups.<br>sourceClusterId | **string**<br><p>Идентификатор кластера PostgreSQL, для которого была создана резервная копия.</p> 
backups.<br>startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/postgresql/Cluster/listBackups#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/postgresql/Cluster/listBackups#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/postgresql/Cluster/listBackups#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/postgresql/Cluster/listBackups#responses">nextPageToken</a> для перебора страниц результатов.</p> 