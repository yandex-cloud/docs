---
editable: false
---

# Метод get
Возвращает указанный ресурс Database для PostgreSQL.
 
Чтобы получить список доступных ресурсов Database для PostgreSQL, отправьте запрос [list](/docs/managed-postgresql/api-ref/Database/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
databaseName | Обязательное поле. Имя запрашиваемого ресурса Database для PostgreSQL. Чтобы получить имя базы данных, используйте запрос [list](/docs/managed-postgresql/api-ref/Database/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "owner": "string",
  "lcCollate": "string",
  "lcCtype": "string",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }
  ]
}
```
Ресурс Database для PostgreSQL. Подробнее см. в разделе [Developer's Guide](/docs/managed-postgresql/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера PostgreSQL, к которому принадлежит база данных.</p> 
owner | **string**<br><p>Имя пользователя, назначенного владельцем базы данных.</p> 
lcCollate | **string**<br><p>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания.</p> 
lcCtype | **string**<br><p>POSIX-локаль для классификации символов. Может быть установлена только во время создания.</p> 
extensions[] | **object**<br><p>Расширения PostgreSQL, включенные для базы данных.</p> 
extensions[].<br>name | **string**<br><p>Имя расширения, например ``pg_trgm`` или ``pg_btree``. Расширения, которые поддерживает Managed Service for PostgreSQL, <a href="/docs/managed-postgresql/operations/cluster-extensions">перечислены в документации</a>.</p> 
extensions[].<br>version | **string**<br><p>Версия расширения.</p> 