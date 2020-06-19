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
      "connectTimeout": "integer",
      "receiveTimeout": "integer",
      "sendTimeout": "integer",
      "insertQuorumTimeout": "integer",
      "selectSequentialConsistency": true,
      "maxReplicaDelayForDistributedQueries": "integer",
      "fallbackToStaleReplicasForDistributedQueries": true,
      "replicationAlterPartitionsSync": "integer",
      "distributedProductMode": "string",
      "distributedAggregationMemoryEfficient": true,
      "distributedDdlTaskTimeout": "integer",
      "compile": true,
      "minCountToCompile": "integer",
      "compileExpressions": true,
      "minCountToCompileExpression": "integer",
      "maxBlockSize": "integer",
      "minInsertBlockSizeRows": "integer",
      "minInsertBlockSizeBytes": "integer",
      "maxInsertBlockSize": "integer",
      "minBytesToUseDirectIo": "integer",
      "useUncompressedCache": true,
      "mergeTreeMaxRowsToUseCache": "integer",
      "mergeTreeMaxBytesToUseCache": "integer",
      "mergeTreeMinRowsForConcurrentRead": "integer",
      "mergeTreeMinBytesForConcurrentRead": "integer",
      "maxBytesBeforeExternalGroupBy": "integer",
      "maxBytesBeforeExternalSort": "integer",
      "groupByTwoLevelThreshold": "integer",
      "groupByTwoLevelThresholdBytes": "integer",
      "priority": "integer",
      "maxThreads": "integer",
      "maxMemoryUsage": "integer",
      "maxMemoryUsageForUser": "integer",
      "maxNetworkBandwidth": "integer",
      "maxNetworkBandwidthForUser": "integer",
      "forceIndexByDate": true,
      "forcePrimaryKey": true,
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
      "maxExpandedAstElements": "integer",
      "inputFormatValuesInterpretExpressions": true,
      "inputFormatDefaultsForOmittedFields": true,
      "outputFormatJsonQuote_64BitIntegers": true,
      "outputFormatJsonQuoteDenormals": true,
      "lowCardinalityAllowInNativeFormat": true,
      "emptyResultForAggregationByEmptySet": true,
      "httpConnectionTimeout": "integer",
      "httpReceiveTimeout": "integer",
      "httpSendTimeout": "integer",
      "enableHttpCompression": true,
      "sendProgressInHttpHeaders": true,
      "httpHeadersProgressInterval": "integer",
      "addHttpCorsHeader": true
    },
    "quotas": [
      {
        "intervalDuration": "integer",
        "queries": "integer",
        "errors": "integer",
        "resultRows": "integer",
        "readRows": "integer",
        "executionTime": "integer"
      }
    ]
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
userSpec.<br>settings.<br>readonly | **integer** (int64)<br><p>Ограничивает разрешения для запросов, не относящихся к DDL. Возможные значения:</p> <ul> <li>0 (по умолчанию) - никаких ограничений.</li> <li>1-разрешены только запросы на чтение данных.</li> <li>2 — разрешены запросы на чтение данных и изменение настроек. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly">документации ClickHouse</a>.</li> </ul> <p>Допустимые значения — от 0 до 2 включительно.</p> 
userSpec.<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Разрешены ли запросы DDL. Значение по умолчанию &quot;false&quot;. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>insertQuorum | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Время ожидания соединения в миллисекундах. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Время ожидания приема в миллисекундах. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Время ожидания отправки в миллисекундах. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#connect-timeout-receive-timeout-send-timeout">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Время ожидания записи для кворума в миллисекундах. Значение по умолчанию: 60000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum_timeout">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
userSpec.<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Максимальная задержка реплики в миллисекундах. Если реплика отстает на значение больше установленного, реплика перестает использоваться. Значение по умолчанию: 300000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
userSpec.<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/query_language/alter/#synchronicity-of-alter-queries">документации ClickHouse</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
userSpec.<br>settings.<br>distributedProductMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#distributed-product-mode">документации ClickHouse</a>.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Значение по умолчанию. Запрещает использование этих типов подзапросов (возвращает исключение &quot;Double-distributed in/JOIN subqueries is denied&quot;).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Заменяет базу данных и таблицу в подзапросе локальными для конечного сервера (шарда), оставляя обычный IN / JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Заменяет IN/JOIN запрос на GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Позволяет использовать эти типы подзапросов.</li> </ul> 
userSpec.<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Включен ли режим экономии памяти распределенной агрегации.</p> 
userSpec.<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Время ожидания запросов DDL в миллисекундах.</p> 
userSpec.<br>settings.<br>compile | **boolean** (boolean)<br><p>Включена ли компиляция запросов. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#compile">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>Число структурно идентичных запросов до их компиляции. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#min-count-to-compile">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Включена ли компиляция выражений.</p> 
userSpec.<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>Число идентичных выражений до их компиляции.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Минимальный размер блока в строках при выполнении INSERT запросов. Блоки меньшего размера ClickHouse будет склеивать в один блок. Если установлено значение &quot;0&quot;, ClichHouse не будет склеивать блоки.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Минимальный размер блока в байтах при выполнении INSERT запросов. Блоки меньшего размера ClickHouse будет склеивать в один блок. Если установлено значение &quot;0&quot;, ClichHouse не будет склеивать блоки.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-min_bytes_to_use_direct_io">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#setting-use_uncompressed_cache">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>Максимальный размер запроса в строках для использования кэша несжатых данных. Кэш не используется для запросов, превышающих указанное значение. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#setting-merge_tree_max_rows_to_use_cache">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>Максимальный размер запроса в байтах для использования кэша несжатых данных. Кэш не используется для запросов, превышающих указанное значение.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>Минимальное число строк, считываемых из файла для одновременного чтения. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#setting-merge_tree_min_rows_for_concurrent_read">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>Минимальное число байтов, считываемых из файла для одновременного чтения.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br>
userSpec.<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br>
userSpec.<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br>
userSpec.<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br>
userSpec.<br>settings.<br>priority | **integer** (int64)<br><p>Приоритет запроса.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxThreads | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpec.<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_network_bandwidth">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_network_bandwidth_for_user">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-force_index_by_date">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#force-primary-key">документации ClickHouse</a>.</p> 
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
userSpec.<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-input_format_values_interpret_expressions">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Если значение истинно, то при использовании JSON форматов UInt64 и Int64 числа выводятся в кавычках. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#session_settings-output_format_json_quote_64bit_integers">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Включен ли вывод специальных значений с плавающей запятой ( &quot;+nan&quot;, &quot;-nan&quot;, &quot;+inf&quot; и &quot;-inf&quot;) в формате вывода JSON.</p> 
userSpec.<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br>
userSpec.<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br>
userSpec.<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>Время ожидания соединения в миллисекундах.</p> 
userSpec.<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>Время ожидания приема в миллисекундах.</p> 
userSpec.<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>Время ожидания отправки в миллисекундах.</p> 
userSpec.<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-enable_http_compression">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Включены ли уведомления о ходе выполнения с использованием заголовков X-ClickHouse-Progress. Значение по умолчанию &quot;false&quot;. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-send_progress_in_http_headers">документации ClickHouse</a>.</p> 
userSpec.<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Минимальный интервал между уведомлениями о ходе выполнения, в миллисекундах. Значение по умолчанию: 100.</p> 
userSpec.<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Включен ли заголовок CORS в HTTP-ответах. Значение по умолчанию &quot;false&quot;.</p> 
userSpec.<br>quotas[] | **object**<br><p>Представление квот ClickHouse. Каждая квота связана с пользователем и ограничивает использование ресурсов на определенный интервал. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/quotas/">документации ClickHouse</a>.</p> 
userSpec.<br>quotas[].<br>intervalDuration | **integer** (int64)<br><p>Длительность интервала для квоты в миллисекундах. Минимальное значение - 1 минута.</p> <p>Минимальное значение — 60000.</p> 
userSpec.<br>quotas[].<br>queries | **integer** (int64)<br><p>Общее количество запросов. 0-неограниченно.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>quotas[].<br>errors | **integer** (int64)<br><p>Количество запросов, которые вызвали исключение. 0-неограниченно.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>quotas[].<br>resultRows | **integer** (int64)<br><p>Общее число строк, приведенных в результате. 0-неограниченно.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>quotas[].<br>readRows | **integer** (int64)<br><p>Общее число исходных строк, считанных из таблиц для выполнения запроса, на всех удаленных серверах. 0-неограниченно.</p> <p>Минимальное значение — 0.</p> 
userSpec.<br>quotas[].<br>executionTime | **integer** (int64)<br><p>Общее время выполнения запроса, в миллисекундах. 0-неограниченно.</p> <p>Минимальное значение — 0.</p> 
 
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