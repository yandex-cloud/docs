---
editable: false
---

# Метод get
Возвращает указанный ресурс User для ClickHouse.
 
Чтобы получить список доступных ресурсов User для ClickHouse, отправьте запрос [list](/docs/managed-clickhouse/api-ref/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-clickhouse/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя запрашиваемого ресурса User для ClickHouse. Чтобы получить имя пользователя, используйте запрос [list](/docs/managed-clickhouse/api-ref/User/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
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
```
Ресурс User для ClickHouse. Подробнее см. в разделе [Developer's guide](/docs/managed-clickhouse/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя базы данных ClickHouse.</p> 
clusterId | **string**<br><p>Идентификатор кластера ClickHouse, к которому принадлежит пользователь.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
settings | **object**<br><p>Пользовательские настройки ClickHouse. Поддерживаемые параметры входят в число параметров, описанных в разделе <a href="https://clickhouse.yandex/docs/ru/operations/settings/">документации ClickHouse</a>.</p> 
settings.<br>readonly | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly">документации ClickHouse</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
settings.<br>allowDdl | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl">документации ClickHouse</a>.</p> 
settings.<br>insertQuorum | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Время ожидания записи для кворума в миллисекундах. Значение по умолчанию: 60000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum_timeout">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency">документации ClickHouse</a>.</p> 
settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Максимальная задержка реплики в миллисекундах. Если реплика отстает на значение больше установленного, реплика перестает использоваться. Значение по умолчанию: 300000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">документации ClickHouse</a>.</p> 
settings.<br>maxThreads | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
settings.<br>maxBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
settings.<br>maxMemoryUsage | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxRowsToRead | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxBytesToRead | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>readOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>groupByOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxRowsToSort | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxBytesToSort | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>sortOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxResultRows | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxResultBytes | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>resultOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>distinctOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>transferOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxExecutionTime | **integer** (int64)<br><p>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>timeoutOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode">документации ClickHouse</a>.</p> 
settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
settings.<br>maxQuerySize | **integer** (int64)<br><p>Наибольшая часть запроса, которая может быть передана в RAM для разбора с помощью анализатора SQL, в байтах. Значение по умолчанию: 262144. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
settings.<br>maxAstDepth | **integer** (int64)<br><p>Максимальная глубина синтаксического дерева запроса. Значение по умолчанию: 1000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-depth">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
settings.<br>maxAstElements | **integer** (int64)<br><p>Максимальный размер синтаксического дерева запроса в количестве узлов. Значение по умолчанию: 50000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000.</p> <p>Значение должно быть больше 0.</p> 