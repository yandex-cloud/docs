# Метод get
Возвращает указанный ресурс User для PostgreSQL.
 
Чтобы получить список доступных ресурсов User для PostgreSQL,
отправьте запрос [list](/docs/mdb/api-ref/postgresql/User/list).
 
## HTTP-запрос
`GET /managed-postgresql/v1/clusters/{clusterId}/users/{userName}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина — 50 символов.
userName | Обязательное поле. Обязательное поле. Имя запрашиваемого ресурса User для PostgreSQL. Чтобы получить имя пользователя, используйте запрос [list](/docs/mdb/api-ref/postgresql/User/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс User для PostgreSQL. Подробнее см. в разделе [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts).
 
Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL.
clusterId | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь.
permissions | **object**<br>Набор разрешений, предоставленных пользователю.
permissions.<br>databaseName | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение.
connLimit | **string** (int64)<br>Количество доступных пользователю подключений к базе данных.