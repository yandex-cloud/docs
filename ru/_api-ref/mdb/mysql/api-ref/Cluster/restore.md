---
editable: false
---

# Метод restore
Создает новый кластер MySQL с использованием указанной резервной копии.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters:restore
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "backupId": "string",
  "time": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true
    },

    // `configSpec` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`
    "mysqlConfig_5_7": {
      "innodbBufferPoolSize": "integer",
      "maxConnections": "integer",
      "longQueryTime": "number",
      "generalLog": true,
      "auditLog": true,
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "integer",
      "defaultAuthenticationPlugin": "string",
      "innodbFlushLogAtTrxCommit": "integer",
      "innodbLockWaitTimeout": "integer",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": true,
      "netReadTimeout": "integer",
      "netWriteTimeout": "integer",
      "groupConcatMaxLen": "integer",
      "tmpTableSize": "integer",
      "maxHeapTableSize": "integer",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": true,
      "innodbNumaInterleave": true,
      "innodbLogBufferSize": "integer",
      "innodbLogFileSize": "integer",
      "innodbIoCapacity": "integer",
      "innodbIoCapacityMax": "integer",
      "innodbReadIoThreads": "integer",
      "innodbWriteIoThreads": "integer",
      "innodbPurgeThreads": "integer",
      "innodbThreadConcurrency": "integer",
      "innodbTempDataFileMaxSize": "integer",
      "threadCacheSize": "integer",
      "threadStack": "integer",
      "joinBufferSize": "integer",
      "sortBufferSize": "integer",
      "tableDefinitionCache": "integer",
      "tableOpenCache": "integer",
      "tableOpenCacheInstances": "integer",
      "explicitDefaultsForTimestamp": true,
      "autoIncrementIncrement": "integer",
      "autoIncrementOffset": "integer",
      "syncBinlog": "integer",
      "binlogCacheSize": "integer",
      "binlogGroupCommitSyncDelay": "integer",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": true,
      "rplSemiSyncMasterWaitForSlaveCount": "integer",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "integer",
      "mdbPreserveBinlogBytes": "integer",
      "interactiveTimeout": "integer",
      "waitTimeout": "integer",
      "mdbOfflineModeEnableLag": "integer",
      "mdbOfflineModeDisableLag": "integer",
      "rangeOptimizerMaxMemSize": "integer"
    },
    "mysqlConfig_8_0": {
      "innodbBufferPoolSize": "integer",
      "maxConnections": "integer",
      "longQueryTime": "number",
      "generalLog": true,
      "auditLog": true,
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "integer",
      "defaultAuthenticationPlugin": "string",
      "innodbFlushLogAtTrxCommit": "integer",
      "innodbLockWaitTimeout": "integer",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": true,
      "netReadTimeout": "integer",
      "netWriteTimeout": "integer",
      "groupConcatMaxLen": "integer",
      "tmpTableSize": "integer",
      "maxHeapTableSize": "integer",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": true,
      "innodbNumaInterleave": true,
      "innodbLogBufferSize": "integer",
      "innodbLogFileSize": "integer",
      "innodbIoCapacity": "integer",
      "innodbIoCapacityMax": "integer",
      "innodbReadIoThreads": "integer",
      "innodbWriteIoThreads": "integer",
      "innodbPurgeThreads": "integer",
      "innodbThreadConcurrency": "integer",
      "innodbTempDataFileMaxSize": "integer",
      "threadCacheSize": "integer",
      "threadStack": "integer",
      "joinBufferSize": "integer",
      "sortBufferSize": "integer",
      "tableDefinitionCache": "integer",
      "tableOpenCache": "integer",
      "tableOpenCacheInstances": "integer",
      "explicitDefaultsForTimestamp": true,
      "autoIncrementIncrement": "integer",
      "autoIncrementOffset": "integer",
      "syncBinlog": "integer",
      "binlogCacheSize": "integer",
      "binlogGroupCommitSyncDelay": "integer",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": true,
      "rplSemiSyncMasterWaitForSlaveCount": "integer",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "integer",
      "regexpTimeLimit": "integer",
      "mdbPreserveBinlogBytes": "integer",
      "interactiveTimeout": "integer",
      "waitTimeout": "integer",
      "mdbOfflineModeEnableLag": "integer",
      "mdbOfflineModeDisableLag": "integer",
      "rangeOptimizerMaxMemSize": "integer"
    },
    // конец списка возможных полей`configSpec`

  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "networkId": "string",
  "folderId": "string"
}
```

 
Поле | Описание
--- | ---
backupId | **string**<br><p>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос <a href="/docs/managed-mysql/api-ref/Cluster/listBackups">listBackups</a>.</p> 
time | **string** (date-time)<br><p>Обязательное поле. Момент времени, на который должен быть восстановлен кластер MySQL.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Обязательное поле. Имя нового кластера MySQL. Имя должно быть уникальным в каталоге.</p> <p>Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.</p> 
description | **string**<br><p>Описание нового кластера MySQL.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MySQL в виде пар `key:value`. Максимум 64 на ресурс. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.</p> 
environment | **string**<br><p>Среда развертывания для нового кластера MySQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Конфигурация для создаваемого кластера MySQL.</p> 
configSpec.<br>version | **string**<br><p>Версия MySQL, используемая в кластере. Возможные значения:</p> <ul> <li>5.7</li> <li>8.0</li> </ul> 
configSpec.<br>resources | **object**<br>Ресурсы, выделенные хостам MySQL.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mysql/concepts/instance-types">документации</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
configSpec.<br>access | **object**<br>Политика доступа к БД.<br>
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
configSpec.<br>mysqlConfig_5_7 | **object**<br>Конфигурация для кластера MySQL 5.7. <br>`configSpec` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br><p>Поля и структура `MysqlConfig5_7` отражает параметры конфигурации MySQL 5.7.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
configSpec.<br>mysqlConfig_5_7.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
configSpec.<br>mysqlConfig_8_0 | **object**<br>Конфигурация для кластера MySQL 8.0. <br>`configSpec` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br><p>Поля и структура `MysqlConfig8_0` отражает параметры конфигурации MySQL 8.0.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
configSpec.<br>mysqlConfig_8_0.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
configSpec.<br>mysqlConfig_8_0.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>regexpTimeLimit | **integer** (int64)<br><p>Ограничение времени выполнения регулярных выражений выполняемых REGEXP_LIKE и похожими функциями</p> <p>Подробнее см. в [описании переменной в документации MySQL]((https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit).</p> <p>Допустимые значения — от 0 до 1048576 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
configSpec.<br>mysqlConfig_8_0.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
hostSpecs[] | **object**<br><p>Конфигурации для хостов MySQL, которые должны быть добавлены к кластеру, создаваемогму из резервной копии.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле <a href="/docs/managed-mysql/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля `assignPublicIp`.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
networkId | **string**<br><p>Идентификатор сети, в которой нужно создать кластер MySQL.</p> <p>Максимальная длина строки в символах — 50.</p> 
folderId | **string**<br><p>Идентификатор каталога, в котором нужно создать кластер MySQL.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.</p> 