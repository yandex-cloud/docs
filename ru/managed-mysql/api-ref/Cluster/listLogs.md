---
editable: false
---

# Метод listLogs
Получает логи для указанного кластера MySQL.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MySQL, для которого следует запросить логи. Чтобы получить идентификатор MySQL кластера, используйте запрос [list](/docs/managed-mysql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы из таблицы логов для запроса. Если столбцы не указаны, записи логов возвращаются целиком.
serviceType | Тип сервиса, для которого следует запросить логи.<ul> <li>MYSQL_ERROR: Лог ошибок MySQL.</li> <li>MYSQL_GENERAL: Общий лог запросов MySQL.</li> <li>MYSQL_SLOW_QUERY: Лог медленных запросов MySQL.</li> <li>MYSQL_AUDIT: Лог аудита MySQL.</li> </ul> 
fromTime | Начало периода, для которого следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Конец периода, для которого следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params), сервис вернет значение [nextPageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#query_params) равным значению поля [nextPageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
alwaysNextPageToken | Всегда возвращать `next_page_token`, даже если текущая страница пуста.
 
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
logs[] | **object**<br><p>Запрошенные записи логов.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Отметка времени для записи журнала в текстовом формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logs[].<br>message | **object**<br><p>Содержание записи журнала.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageSize</a>, используйте <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mysql/api-ref/Cluster/listLogs#responses">nextPageToken</a> для перебора страниц результатов.</p> 