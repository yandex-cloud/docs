# Метод list
Получает список ресурсов Database для указанного кластера PostgreSQL.
 

 
## HTTP-запрос
`GET /managed-postgresql/v1/clusters/{clusterId}/databases`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL, для которого нужно вывести список баз данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/Database/list#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/postgresql/Database/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/postgresql/Database/list#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/postgresql/Database/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
databases | **object**<br>Ресурс Database для PostgreSQL. Подробнее см. в разделе [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts).
databases.<br>name | **string**<br>Имя базы данных.
databases.<br>clusterId | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит база данных.
databases.<br>owner | **string**<br>Имя пользователя, назначенного владельцем базы данных.
databases.<br>lcCollate | **string**<br>Локаль для порядка сортировки строк. Может быть установлена только при создании.
databases.<br>lcCtype | **string**<br>Локаль для классификации символов. Может быть установлена только при создании.
databases.<br>extensions | **object**<br>Расширения PostgreSQL, включенные для базы данных.
databases.<br>extensions.<br>name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, поддерживаемые MDB, приведены в [документации сервиса](/docs/mdb/concepts).
databases.<br>extensions.<br>version | **string**<br>Версия расширения.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/Database/list#query_params), используйте [nextPageToken](/docs/mdb/api-ref/postgresql/Database/list#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/postgresql/Database/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/postgresql/Database/list#responses) для перебора страниц результатов.