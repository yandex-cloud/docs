---
editable: false
---

# Метод listLogs
Возвращает логи для указанного кластера SQL Server.
 
Для получения дополнительной информации о логах см. раздел [Просмотр логов кластера](/docs/managed-sqlserver/operations/cluster-logs)" в документации.
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера SQL Server, для которого нужно получить логи.  Чтобы получить идентификатор кластера SQL Server, используйте запрос [list](/docs/managed-sqlserver/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы, которые нужно запросить из лога.  Если столбцы не указаны, записи логов возвращаются целиком.
serviceType | Тип сервиса, для которого следует запросить логи.<ul> <li>SQLSERVER_ERROR: Лог с ошибками SQL Server.</li> <li>SQLSERVER_APPLICATION: Лог приложений SQL Server.</li> </ul> 
fromTime | Временная метка, начиная с которой следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Временная метка, до которой следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/listLogs#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
alwaysNextPageToken | Всегда возвращать `next_page_token`, даже если текущая страница пуста.
filter | Выражение, позволяющее отфильтровать информацию о ресурсах в ответе, оставив только нужную.  В этом выражении должны быть указаны: 1. Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю [LogRecord.logs.message.hostname]. 2. Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-z0-9.-]{1,61}$`.  Примеры фильтров: `message.hostname='node1.db.cloud.yandex.net'`  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logs": [
    {
      "timestamp": "string",
      "message": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
logs[] | **object**<br><p>Запрошенные записи в логе.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Временная метка для записи в логе.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logs[].<br>message | **object**<br><p>Содержимое записи в логе.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageSize</a>, используйте `next_page_token` в качестве значения параметра <a href="/docs/managed-sqlserver/api-ref/Cluster/listLogs#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов.</p> 