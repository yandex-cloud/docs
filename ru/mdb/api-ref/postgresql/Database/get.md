# Метод get
Возвращает указанный ресурс Database для PostgreSQL.
 
Чтобы получить список доступных ресурсов Database для PostgreSQL,
отправьте запрос [list](/docs/mdb/api-ref/postgresql/Database/list).
 
## HTTP-запрос
`GET /managed-postgresql/v1/clusters/{clusterId}/databases/{databaseName}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина — 50 символов.
databaseName | Обязательное поле. Имя запрашиваемого ресурса Database для PostgreSQL. Чтобы получить имя базы данных, используйте запрос [list](/docs/mdb/api-ref/postgresql/Database/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Database для PostgreSQL. Подробнее см. в разделе [Взаимосвязь
ресурсов сервиса](/docs/mdb/concepts).
 
Поле | Описание
--- | ---
name | **string**<br>Имя базы данных.
clusterId | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит база данных.
owner | **string**<br>Имя пользователя, назначенного владельцем базы данных.
lcCollate | **string**<br>Локаль для порядка сортировки строк. Может быть установлена только при создании.
lcCtype | **string**<br>Локаль для классификации символов. Может быть установлена только при создании.
extensions | **object**<br>Расширения PostgreSQL, включенные для базы данных.
extensions.<br>name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, поддерживаемые MDB, приведены в [документации сервиса](/docs/mdb/concepts).
extensions.<br>version | **string**<br>Версия расширения.