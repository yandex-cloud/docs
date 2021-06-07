---
editable: false
---

# Метод streamLogs
То же самое, что ListLogs, с той разницей, что со стороны сервера передается поток логов. Допускается использовать семантику 'tail-f' при работе с потоком
логов.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}:stream_logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Обязательное поле. Идентификатор кластера ClickHouse.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы, которые нужно запросить из лога.
serviceType | <ul> <li>CLICKHOUSE: Логи работы ClickHouse.</li> </ul> 
fromTime | Временная метка, начиная с которой следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Временная метка, до которой следует запросить логи. Если значение этого поля не задано, то будут отправлены все существующие записи в логе, а затем и новые по мере их появления. В сущности, это эквивалентно семантике `tail -f`.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
recordToken | Токен записи. Задайте значение [recordToken](/docs/managed-clickhouse/api-ref/Cluster/streamLogs#query_params) равным значению `nextRecordToken`, возвращенному предыдущим запросом StreamLogs, чтобы продолжить стриминг со следующей записи в логе.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "record": {
    "timestamp": "string",
    "message": "object"
  },
  "nextRecordToken": "string"
}
```

 
Поле | Описание
--- | ---
record | **object**<br><p>Одна из запрошенных записей в логе.</p> 
record.<br>timestamp | **string** (date-time)<br><p>Отметка времени для записи журнала в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> текстовом формате.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
record.<br>message | **object**<br><p>Содержимое записи в логе.</p> 
nextRecordToken | **string**<br><p>Этот токен позволяет продолжить работу с потоком логов, начиная с этой записи. Чтобы продолжить работу с потоком, укажите значение ``nextRecordToken`` в качестве значения параметра <a href="/docs/managed-clickhouse/api-ref/Cluster/streamLogs#query_params">recordToken</a> в следующем запросе StreamLogs. Это значение взаимозаменяемо с <a href="/docs/managed-clickhouse/api-ref/Cluster/listLogs#responses">nextPageToken</a> из метода ListLogs.</p> 