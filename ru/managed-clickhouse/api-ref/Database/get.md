# Метод get
Возвращает указанный ресурс Database для ClickHouse.
 
Чтобы получить список доступных ресурсов Database для ClickHouse,
отправьте запрос [list](/docs/mdb/api-ref/clickhouse/Database/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/clickhouse/Cluster/list).  Максимальная длина строки в символах — 50.
databaseName | Обязательное поле. Имя возвращаемого ресурса Database для базы данных ClickHouse. Чтобы получить имя базы данных, используйте запрос [list](/docs/mdb/api-ref/clickhouse/Database/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Database для ClickHouse. Подробнее см. в [документации MDB](/docs/mdb/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит база данных.</p> 