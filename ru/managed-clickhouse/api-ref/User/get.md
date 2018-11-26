# Метод get
Возвращает указанный ресурс User для ClickHouse.
 
Чтобы получить список доступных ресурсов User для ClickHouse,
отправьте запрос [list](/docs/managed-clickhouse/api-ref//User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-clickhouse/api-ref//Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя запрашиваемого ресурса User для ClickHouse. Чтобы получить имя пользователя, используйте запрос [list](/docs/managed-clickhouse/api-ref//User/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс User для ClickHouse. Подробнее см. в [документации MDB](/docs/managed-clickhouse/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя ClickHouse.</p> 
clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит пользователь.</p> 
permissions | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions.<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
