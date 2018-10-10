# Метод list
Получение списка ресурсов Backup для указанного каталога.
 

 
## HTTP-запрос
`GET /managed-clickhouse/v1/backups`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для вывода списка резервных копий. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/clickhouse/Backup/list#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/clickhouse/Backup/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/clickhouse/Backup/list#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/clickhouse/Backup/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
backups | **object**<br>Ресурс Backup для ClickHouse. Подробное описание см. в разделе [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts).
backups.<br>id | **string**<br>Идентификатор резервной копии.
backups.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит резервная копия.
backups.<br>createdAt | **string** (date-time)<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) (т. е. когда операция резервного копирования была завершена).
backups.<br>sourceClusterId | **string**<br>Идентификатор кластера ClickHouse, для которого была создана резервная копия.
backups.<br>startedAt | **string** (date-time)<br>Время запуска операции резервного копирования.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/clickhouse/Backup/list#query_params), используйте [nextPageToken](/docs/mdb/api-ref/clickhouse/Backup/list#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/clickhouse/Backup/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/clickhouse/Backup/list#responses) для перебора страниц результатов.