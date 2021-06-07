---
editable: false
---

# Метод list
Получает список ресурсов Database для указанного кластера PostgreSQL.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/databases
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL, для которого нужно вывести список баз данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-postgresql/api-ref/Database/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-postgresql/api-ref/Database/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-postgresql/api-ref/Database/list#query_params) равным значению поля [nextPageToken](/docs/managed-postgresql/api-ref/Database/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
databases[] | **object**<br><p>Ресурс Database для PostgreSQL. Подробнее см. в разделе <a href="/docs/managed-postgresql/concepts">Developer's Guide</a>.</p> 
databases[].<br>name | **string**<br><p>Имя базы данных.</p> 
databases[].<br>clusterId | **string**<br><p>Идентификатор кластера PostgreSQL, к которому принадлежит база данных.</p> 
databases[].<br>owner | **string**<br><p>Имя пользователя, назначенного владельцем базы данных.</p> 
databases[].<br>lcCollate | **string**<br><p>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания.</p> 
databases[].<br>lcCtype | **string**<br><p>POSIX-локаль для классификации символов. Может быть установлена только во время создания.</p> 
databases[].<br>extensions[] | **object**<br><p>Расширения PostgreSQL, включенные для базы данных.</p> 
databases[].<br>extensions[].<br>name | **string**<br><p>Имя расширения, например ``pg_trgm`` или ``pg_btree``. Расширения, которые поддерживает Managed Service for PostgreSQL, <a href="/docs/managed-postgresql/operations/cluster-extensions">перечислены в документации</a>.</p> 
databases[].<br>extensions[].<br>version | **string**<br><p>Версия расширения.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageSize</a>, используйте <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-postgresql/api-ref/Database/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-postgresql/api-ref/Database/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 