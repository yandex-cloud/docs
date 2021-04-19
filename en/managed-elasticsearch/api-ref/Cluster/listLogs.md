---
editable: false
---

# Метод listLogs
Получает логи для указанного кластера Elasticsearch.
 
Дополнительные сведения о логах см. в разделе документации [Logs](/docs/managed-elasticsearch/operations/cluster-logs).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}:logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Elasticsearch, для которого нужно получить логи.  Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [list](/docs/managed-elasticsearch/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы, которые нужно запросить из лога.  Если столбцы не указаны, записи логов возвращаются целиком.
fromTime | Временная метка, начиная с которой следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Временная метка, до которой следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
alwaysNextPageToken | Флаг, определяющий поведение при предоставлении маркера следующей страницы.  Если этот флаг установлен в `true`, этот метод API всегда будет возвращать [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listLogs#responses), даже если текущая страница пуста.
filter | Выражение, позволяющее отфильтровать информацию о ресурсах в ответе, оставив только нужную.  В этом выражении должны быть указаны: 1. Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю `hostname`. 2. Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-z0-9.-]{1,61}$`.  Пример фильтра: `hostname='node1.db.cloud.yandex.net'`  Максимальная длина строки в символах — 1000.
 
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
logs[] | **object**<br><p>Записи в журнале.</p> 
logs[].<br>timestamp | **string** (date-time)<br><p>Временная метка для записи в логе.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
logs[].<br>message | **object**<br><p>Содержимое записи в логе.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#query_params">pageSize</a>, используйте `next_page_token` в качестве значения параметра <a href="/docs/managed-elasticsearch/api-ref/Cluster/listLogs#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов.</p> <p>Это значение взаимозаменяемо с `nextRecordToken` из метода StreamLogs.</p> 