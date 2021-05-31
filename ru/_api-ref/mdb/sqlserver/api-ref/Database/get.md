---
editable: false
---

# Метод get
Возвращает указанную базу данных SQL Server.
 
Чтобы получить список доступных баз данных SQL Server, выполните запрос [list](/docs/managed-sqlserver/api-ref/Database/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера SQL Server, которому принадлежит база данных.  Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-sqlserver/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
databaseName | Обязательное поле. Имя запрашиваемой базы данных SQL Server.  Чтобы получить имя базы данных, используйте запрос [list](/docs/managed-sqlserver/api-ref/Database/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
База данных SQL Server.
Для получения дополнительной информации см. раздел документации [Взаимосвязь ресурсов сервиса](/docs/managed-sqlserver/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера SQL Server, которому принадлежит база данных.</p> 