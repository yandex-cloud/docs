---
editable: false
---

# Метод create
Создает пользователя ClickHouse в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, в котором следует создать пользователя. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-clickhouse/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "userSpec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "databaseName": "string"
      }
    ],
    "settings": {
      "readonly": "integer",
      "allowDdl": true,
      "insertQuorum": "integer",
      "insertQuorumTimeout": "integer",
      "selectSequentialConsistency": true,
      "maxReplicaDelayForDistributedQueries": "integer",
      "fallbackToStaleReplicasForDistributedQueries": true,
      "maxThreads": "integer",
      "maxBlockSize": "integer",
      "maxInsertBlockSize": "integer",
      "maxMemoryUsage": "integer",
      "maxMemoryUsageForUser": "integer",
      "maxRowsToRead": "integer",
      "maxBytesToRead": "integer",
      "readOverflowMode": "string",
      "maxRowsToGroupBy": "integer",
      "groupByOverflowMode": "string",
      "maxRowsToSort": "integer",
      "maxBytesToSort": "integer",
      "sortOverflowMode": "string",
      "maxResultRows": "integer",
      "maxResultBytes": "integer",
      "resultOverflowMode": "string",
      "maxRowsInDistinct": "integer",
      "maxBytesInDistinct": "integer",
      "distinctOverflowMode": "string",
      "maxRowsToTransfer": "integer",
      "maxBytesToTransfer": "integer",
      "transferOverflowMode": "string",
      "maxExecutionTime": "integer",
      "timeoutOverflowMode": "string",
      "maxColumnsToRead": "integer",
      "maxTemporaryColumns": "integer",
      "maxTemporaryNonConstColumns": "integer",
      "maxQuerySize": "integer",
      "maxAstDepth": "integer",
      "maxAstElements": "integer",
      "maxExpandedAstElements": "integer"
    }
  }
}
```

 
Поле | Описание
--- | ---
userSpec | **object**<br><p>Обязательное поле. Свойства создаваемого пользователя.</p> 
userSpec.<br>name | **string**<br><p>Обязательное поле. Имя пользователя базы данных ClickHouse.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]*</code>.</p> 
userSpec.<br>password | **string**<br><p>Обязательное поле. Пароль пользователя ClickHouse.</p> <p>Длина строки в символах должна быть от 8 до 128.</p> 
userSpec.<br>permissions[] | **object**<br><p>Набор разрешений, которые следует предоставить пользователю.</p> 
userSpec.<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
userSpec.<br>settings | **object**<br><p>Пользовательские настройки ClickHouse. Поддерживаемые параметры входят в число параметров, описанных в разделе <a href="https://clickhouse.yandex/docs/ru/operations/settings/">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>readonly | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly">документации ClickHouse</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
userSpec.<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>insertQuorum | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Время ожидания записи для кворума в миллисекундах. Значение по умолчанию: 60000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum_timeout">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
userSpec.<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Максимальная задержка реплики в миллисекундах. Если реплика отстает на значение больше установленного, реплика перестает использоваться. Значение по умолчанию: 300000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
userSpec.<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxThreads | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>readOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>groupByOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>sortOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxResultRows | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>resultOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>distinctOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>transferOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>timeoutOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>Наибольшая часть запроса, которая может быть передана в RAM для разбора с помощью анализатора SQL, в байтах. Значение по умолчанию: 262144. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>Максимальная глубина синтаксического дерева запроса. Значение по умолчанию: 1000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-depth">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxAstElements | **integer** (int64)<br><p>Максимальный размер синтаксического дерева запроса в количестве узлов. Значение по умолчанию: 50000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000.</p> <p>Значение должно быть больше 0.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 