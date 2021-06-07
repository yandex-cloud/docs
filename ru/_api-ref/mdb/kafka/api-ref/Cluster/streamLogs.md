---
editable: false
---

# Метод streamLogs
То же самое, что [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs), с той разницей, что со стороны сервера передается поток логов. Допускается использовать семантику `tail -f` при работе с
потоком логов.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}:stream_logs
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Apache Kafka®.  Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [list](/docs/managed-kafka/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
columnFilter | Столбцы, которые нужно запросить из лога.  Если столбцы не указаны, записи логов возвращаются целиком.
fromTime | Временная метка, начиная с которой следует запросить логи.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
toTime | Временная метка, до которой следует запросить логи.  Если значение этого поля не задано, то будут отправлены все существующие записи в логе, а затем и новые по мере их появления. В сущности, это эквивалентно семантике `tail -f`.  Строка в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
recordToken | Токен записи.  Задайте значение [recordToken](/docs/managed-kafka/api-ref/Cluster/streamLogs#query_params) равным значению `nextRecordToken`, возвращенному предыдущим запросом [streamLogs](/docs/managed-kafka/api-ref/Cluster/streamLogs) чтобы продолжить стриминг со следующей записи в логе.  Максимальная длина строки в символах — 100.
filter | Выражение, позволяющее отфильтровать информацию о ресурсах в ответе, оставив только нужную.  В этом выражении должны быть указаны: 1. Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю `hostname`. 2. Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Должно содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Пример фильтра: `hostname='node1.db.cloud.yandex.net'`  Максимальная длина строки в символах — 1000.
 
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
record | **object**<br><p>Одна из запрошенных записей в логе.</p> <p>Записи в журнале.</p> 
record.<br>timestamp | **string** (date-time)<br><p>Временная метка для записи в логе.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
record.<br>message | **object**<br><p>Содержимое записи в логе.</p> 
nextRecordToken | **string**<br><p>Этот токен позволяет продолжить работу с потоком логов, начиная с этой записи.</p> <p>Чтобы продолжить работу с потоком, укажите значение ``nextRecordToken`` в качестве значения параметра <a href="/docs/managed-kafka/api-ref/Cluster/streamLogs#query_params">recordToken</a> в следующем запросе StreamLogs.</p> <p>Это значение взаимозаменяемо с <a href="/docs/managed-kafka/api-ref/Cluster/listLogs#responses">nextPageToken</a> из метода ListLogs.</p> 