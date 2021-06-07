---
editable: false
---

# Метод list
Возвращает список кластеров MySQL, принадлежащих указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров MySQL. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mysql/api-ref/Cluster/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-mysql/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mysql/api-ref/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/managed-mysql/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](/docs/managed-mysql/api-ref/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Должен содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "environment": "string",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
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

        // `clusters[].config` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`
        "mysqlConfig_5_7": {
          "effectiveConfig": {
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
          "userConfig": {
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
          "defaultConfig": {
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
          }
        },
        "mysqlConfig_8_0": {
          "effectiveConfig": {
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
          "userConfig": {
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
          "defaultConfig": {
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
          }
        },
        // конец списка возможных полей`clusters[].config`

      },
      "networkId": "string",
      "health": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>Кластер MySQL. Подробнее см. в <a href="/docs/managed-mysql/concepts">документации</a>.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера MySQL. Этот идентификатор Managed Service for MySQL генерирует при создании.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер MySQL.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера MySQL. Имя должно быть уникальным в каталоге, соответствовать RFC 1035 и иметь длину 1-63 символа.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера MySQL. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Пользовательские метки для кластера MySQL в виде пар ``key:value``. Максимум 64 на ресурс.</p> 
clusters[].<br>environment | **string**<br><p>Среда развертывания кластера MySQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к данному кластеру MySQL.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера MySQL.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера MySQL.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Версия серверного программного обеспечения MySQL.</p> 
clusters[].<br>config.<br>resources | **object**<br>Ресурсы, выделенные хостам MySQL.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mysql/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
clusters[].<br>config.<br>access | **object**<br>Политика доступа к БД<br>
clusters[].<br>config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
clusters[].<br>config.<br>mysqlConfig_5_7 | **object**<br>Конфигурация сервера MySQL 5.7. <br>`clusters[].config` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br>
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MySQL 5.7 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``MysqlConfig5_7`` отражает параметры конфигурации MySQL 5.7.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MySQL 5.7.</p> <p>Поля и структура ``MysqlConfig5_7`` отражает параметры конфигурации MySQL 5.7.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MySQL 5.7.</p> <p>Поля и структура ``MysqlConfig5_7`` отражает параметры конфигурации MySQL 5.7.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0 | **object**<br>Конфигурация сервера MySQL 8.0. <br>`clusters[].config` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br>
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MySQL 8.0 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Поля и структура ``MysqlConfig8_0`` отражает параметры конфигурации MySQL 8.0.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>regexpTimeLimit | **integer** (int64)<br><p>Ограничение времени выполнения регулярных выражений выполняемых REGEXP_LIKE и похожими функциями</p> <p>Подробнее см. в [описании переменной в документации MySQL]((https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit).</p> <p>Допустимые значения — от 0 до 1048576 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MySQL 8.0.</p> <p>Поля и структура ``MysqlConfig8_0`` отражает параметры конфигурации MySQL 8.0.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>regexpTimeLimit | **integer** (int64)<br><p>Ограничение времени выполнения регулярных выражений выполняемых REGEXP_LIKE и похожими функциями</p> <p>Подробнее см. в [описании переменной в документации MySQL]((https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit).</p> <p>Допустимые значения — от 0 до 1048576 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>userConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MySQL 8.0.</p> <p>Поля и структура ``MysqlConfig8_0`` отражает параметры конфигурации MySQL 8.0.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 1073741824 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin">описании переменной в документации MySQL</a>.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Частота записи лога транзакций на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Максимальное время ожидания блокировки строки для транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 28800 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>transactionIsolation | **string**<br><p>Уровень изоляции транзакций по-умолчанию.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Выводить всю информацию о взаимных блокировках в журнал ошибок.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>netReadTimeout | **integer** (int64)<br><p>Максимальное время ожидания чтения при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>netWriteTimeout | **integer** (int64)<br><p>Максимальное время ожидания записи при передаче данных по сети.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 1200 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>groupConcatMaxLen | **integer** (int64)<br><p>Максимальный размер результата для функции GROUP_CONCAT()</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 4 до 33554432 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tmpTableSize | **integer** (int64)<br><p>Максимальный размер временных таблиц в памяти, прежде чем они будут помещены на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxHeapTableSize | **integer** (int64)<br><p>Максимальный размер пользователских MEMORY таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 16384 до 134217728 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>defaultTimeZone | **string**<br><p>Часовой пояс сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>characterSetServer | **string**<br><p>Кодировка сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>collationServer | **string**<br><p>Алгоритм сравнения символов сервера.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Включает адаптивный хэш индекс Innodb</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Включает NUMA interleave политику при выделении памяти для буфера InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave">описании переменной в документации MySQL</a></p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbLogBufferSize | **integer** (int64)<br><p>Размер в байтах буфера, который InnoDB использует при записи логов на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbLogFileSize | **integer** (int64)<br><p>Рамер в байтах одного файла redo логов InnnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 268435456 до 4294967296 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbIoCapacity | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Ограничивает потребление IO InnoDB в фоновых операциях.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 100 до 100000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbReadIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций чтения.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbWriteIoThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций записи.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbPurgeThreads | **integer** (int64)<br><p>Количество I/O потоков Innodb, используемых для операций очистки.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 1 до 16 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Максимальное число потоков, которые могут исполняться внутри InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 1000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Максимальный размер временного табличного пространства InnoDB.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">описании переменной в документации MySQL</a></p> <p>Допустимые значения — от 0 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>threadCacheSize | **integer** (int64)<br><p>Количество потоков, которые кешируются для обработки новых сетевых соединений.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>threadStack | **integer** (int64)<br><p>Размер стэка для потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 131072 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>joinBufferSize | **integer** (int64)<br><p>Минимальный размер буфера, который используется для сканирования простого индекса, сканирования индекса диапазона и объединений таблиц, не использующих индексы.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>sortBufferSize | **integer** (int64)<br><p>Размер буфера, который используется для сортировок в памяти.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 16777216 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tableDefinitionCache | **integer** (int64)<br><p>Размер кеша определений таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tableOpenCache | **integer** (int64)<br><p>Размер кеша открытых таблиц для всех потоков.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 400 до 524288 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>tableOpenCacheInstances | **integer** (int64)<br><p>Количество сегментов кеша открытых таблиц.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 32 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>Эта переменная определяет, разрешает ли сервер определенные нестандартные варианты поведения для значений по умолчанию и обработку значений NULL в столбцах TIMESTAMP.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>autoIncrementIncrement | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>autoIncrementOffset | **integer** (int64)<br><p>Может использоваться для управления работой столбцов AUTO_INCREMENT.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 65535 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>syncBinlog | **integer** (int64)<br><p>Управляет тем, как часто сервер MySQL синхронизирует бинлог с диском.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 4096 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogCacheSize | **integer** (int64)<br><p>Размер кеша для хранения изменений бинлога во время транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 4096 до 67108864 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Определяет, сколько микросекунд операция COMMIT ожидает перед синхронизацией бинлога на диск.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 1000000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogRowImage | **string**<br><p>Для репликации на основе строк в MySQL эта переменная определяет, как образы строк записываются в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>Когда он включен, он заставляет сервер записывать информационные события журнала, такие как события журнала запросов строк, в бинлог.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>Количество реплик которых ожидает мастер при синхронной репликации прежде чем подтвердить фиксацию транзакции.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1 до 2 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>slaveParallelType | **string**<br><p>При использовании многопоточной реплики эта переменная определяет политику, используемую для определения того, какие транзакции могут выполняться параллельно на реплике.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>slaveParallelWorkers | **integer** (int64)<br><p>Устанавливает количество потоков приложения для параллельного выполнения транзакций репликации.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 0 до 64 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>regexpTimeLimit | **integer** (int64)<br><p>Ограничение времени выполнения регулярных выражений выполняемых REGEXP_LIKE и похожими функциями</p> <p>Подробнее см. в [описании переменной в документации MySQL]((https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit).</p> <p>Допустимые значения — от 0 до 1048576 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>Устанавливает размер хранимого на диске бинлога.</p> <p>Допустимые значения — от 1073741824 до 107374182400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>interactiveTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>waitTimeout | **integer** (int64)<br><p>Количество секунд без активности которые ожидает сервер до закрытия соединения с не интерактивным клиентом.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 600 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = ON' чтобы предотвратить чтение устаревших данных.</p> <p>Допустимые значения — от 600 до 432000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Пороговое значение лага репликации (в секундах), после которого MySQL переключится в 'offline_mode = OFF'. Значение должно быть меньше чем mdb_offline_mode_enable_lag.</p> <p>Допустимые значения — от 60 до 86400 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>Ограничение на потребление памяти для range optimizer.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1048576 до 268435456 включительно.</p> 
clusters[].<br>networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
clusters[].<br>health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (``health`` для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (``health`` для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (``health`` по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mysql/api-ref/Cluster/list#query_params">pageSize</a>, используйте <a href="/docs/managed-mysql/api-ref/Cluster/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mysql/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mysql/api-ref/Cluster/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 