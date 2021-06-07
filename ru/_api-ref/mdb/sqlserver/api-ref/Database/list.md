---
editable: false
---

# Метод list
Возвращает список баз данных SQL Server в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}/databases
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера SQL Server, для которого нужно вывести список баз данных.  Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-sqlserver/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-sqlserver/api-ref/Database/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-sqlserver/api-ref/Database/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
databases[] | **object**<br><p>База данных SQL Server. Для получения дополнительной информации см. раздел документации <a href="/docs/managed-sqlserver/concepts">Взаимосвязь ресурсов сервиса</a>.</p> 
databases[].<br>name | **string**<br><p>Имя базы данных.</p> 
databases[].<br>clusterId | **string**<br><p>Идентификатор кластера SQL Server, которому принадлежит база данных.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-sqlserver/api-ref/Database/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/managed-sqlserver/api-ref/Database/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 