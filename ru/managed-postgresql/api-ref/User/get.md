# Метод get
Возвращает указанный ресурс User для PostgreSQL.
 
Чтобы получить список доступных ресурсов User для PostgreSQL,
отправьте запрос [list](/docs/mdb/api-ref/postgresql/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Обязательное поле. Имя запрашиваемого ресурса User для PostgreSQL. Чтобы получить имя пользователя, используйте запрос [list](/docs/mdb/api-ref/postgresql/User/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс User для PostgreSQL. Подробнее см. в [документации MDB](/docs/mdb/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя PostgreSQL.</p> 
clusterId | **string**<br><p>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь.</p> 
permissions | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions.<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
connLimit | **string** (int64)<br><p>Количество доступных пользователю подключений к базе данных.</p> 