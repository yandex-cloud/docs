# Метод restore
Создает новый кластер PostgreSQL с использованием указанной
резервной копии.
 

 
## HTTP-запрос
`POST /managed-postgresql/v1/clusters:restore`
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "backupId": "string",
  "time": "string",
  "timeInclusive": true,
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "poolerConfig": {
      "poolingMode": "string"
    },
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "autofailover": true,

    // `configSpec`включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`
    "postgresqlConfig_9_6": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "replacementSortTuples": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
      "constraintExclusion": "string",
      "cursorTupleFraction": "number",
      "fromCollapseLimit": "integer",
      "joinCollapseLimit": "integer",
      "forceParallelMode": "string",
      "clientMinMessages": "string",
      "logMinMessages": "string",
      "logMinErrorStatement": "string",
      "logMinDurationStatement": "integer",
      "logCheckpoints": true,
      "logConnections": true,
      "logDisconnections": true,
      "logDuration": true,
      "logErrorVerbosity": "string",
      "logLockWaits": true,
      "logStatement": "string",
      "logTempFiles": "integer",
      "searchPath": "string",
      "rowSecurity": true,
      "defaultTransactionIsolation": "string",
      "statementTimeout": "integer",
      "lockTimeout": "integer",
      "idleInTransactionSessionTimeout": "integer",
      "byteaOutput": "string",
      "xmlbinary": "string",
      "xmloption": "string",
      "ginPendingListLimit": "integer",
      "deadlockTimeout": "integer",
      "maxLocksPerTransaction": "integer",
      "maxPredLocksPerTransaction": "integer",
      "arrayNulls": true,
      "backslashQuote": "string",
      "defaultWithOids": true,
      "escapeStringWarning": true,
      "loCompatPrivileges": true,
      "operatorPrecedenceWarning": true,
      "quoteAllIdentifiers": true,
      "standardConformingStrings": true,
      "synchronizeSeqscans": true,
      "transformNullEquals": true,
      "exitOnError": true,
      "seqPageCost": "number",
      "randomPageCost": "number",
      "sqlInheritance": true
    },
    "postgresqlConfig_10": {
      "maxConnections": "integer",
      "sharedBuffers": "integer",
      "tempBuffers": "integer",
      "maxPreparedTransactions": "integer",
      "workMem": "integer",
      "maintenanceWorkMem": "integer",
      "replacementSortTuples": "integer",
      "autovacuumWorkMem": "integer",
      "tempFileLimit": "integer",
      "vacuumCostDelay": "integer",
      "vacuumCostPageHit": "integer",
      "vacuumCostPageMiss": "integer",
      "vacuumCostPageDirty": "integer",
      "vacuumCostLimit": "integer",
      "bgwriterDelay": "integer",
      "bgwriterLruMaxpages": "integer",
      "bgwriterLruMultiplier": "number",
      "bgwriterFlushAfter": "integer",
      "backendFlushAfter": "integer",
      "oldSnapshotThreshold": "integer",
      "walLevel": "string",
      "synchronousCommit": "string",
      "checkpointTimeout": "integer",
      "checkpointCompletionTarget": "number",
      "checkpointFlushAfter": "integer",
      "maxWalSize": "integer",
      "minWalSize": "integer",
      "maxStandbyStreamingDelay": "integer",
      "defaultStatisticsTarget": "integer",
      "constraintExclusion": "string",
      "cursorTupleFraction": "number",
      "fromCollapseLimit": "integer",
      "joinCollapseLimit": "integer",
      "forceParallelMode": "string",
      "clientMinMessages": "string",
      "logMinMessages": "string",
      "logMinErrorStatement": "string",
      "logMinDurationStatement": "integer",
      "logCheckpoints": true,
      "logConnections": true,
      "logDisconnections": true,
      "logDuration": true,
      "logErrorVerbosity": "string",
      "logLockWaits": true,
      "logStatement": "string",
      "logTempFiles": "integer",
      "searchPath": "string",
      "rowSecurity": true,
      "defaultTransactionIsolation": "string",
      "statementTimeout": "integer",
      "lockTimeout": "integer",
      "idleInTransactionSessionTimeout": "integer",
      "byteaOutput": "string",
      "xmlbinary": "string",
      "xmloption": "string",
      "ginPendingListLimit": "integer",
      "deadlockTimeout": "integer",
      "maxLocksPerTransaction": "integer",
      "maxPredLocksPerTransaction": "integer",
      "arrayNulls": true,
      "backslashQuote": "string",
      "defaultWithOids": true,
      "escapeStringWarning": true,
      "loCompatPrivileges": true,
      "operatorPrecedenceWarning": true,
      "quoteAllIdentifiers": true,
      "standardConformingStrings": true,
      "synchronizeSeqscans": true,
      "transformNullEquals": true,
      "exitOnError": true,
      "seqPageCost": "number",
      "randomPageCost": "number"
    },
    // конец списка возможных полей`configSpec`

  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "replicationSource": "string",
      "priority": "integer",
      "configSpec": {

        // `hostSpecs.configSpec`включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`
        "postgresqlConfig_9_6": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
          "replacementSortTuples": "integer",
          "tempFileLimit": "integer",
          "backendFlushAfter": "integer",
          "oldSnapshotThreshold": "integer",
          "maxStandbyStreamingDelay": "integer",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "integer",
          "joinCollapseLimit": "integer",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "integer",
          "logCheckpoints": true,
          "logConnections": true,
          "logDisconnections": true,
          "logDuration": true,
          "logErrorVerbosity": "string",
          "logLockWaits": true,
          "logStatement": "string",
          "logTempFiles": "integer",
          "searchPath": "string",
          "rowSecurity": true,
          "defaultTransactionIsolation": "string",
          "statementTimeout": "integer",
          "lockTimeout": "integer",
          "idleInTransactionSessionTimeout": "integer",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "integer",
          "deadlockTimeout": "integer",
          "maxLocksPerTransaction": "integer",
          "maxPredLocksPerTransaction": "integer",
          "arrayNulls": true,
          "backslashQuote": "string",
          "defaultWithOids": true,
          "escapeStringWarning": true,
          "loCompatPrivileges": true,
          "operatorPrecedenceWarning": true,
          "quoteAllIdentifiers": true,
          "standardConformingStrings": true,
          "synchronizeSeqscans": true,
          "transformNullEquals": true,
          "exitOnError": true,
          "seqPageCost": "number",
          "randomPageCost": "number",
          "sqlInheritance": true
        },
        "postgresqlConfig_10": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
          "replacementSortTuples": "integer",
          "tempFileLimit": "integer",
          "backendFlushAfter": "integer",
          "oldSnapshotThreshold": "integer",
          "maxStandbyStreamingDelay": "integer",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "integer",
          "joinCollapseLimit": "integer",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "integer",
          "logCheckpoints": true,
          "logConnections": true,
          "logDisconnections": true,
          "logDuration": true,
          "logErrorVerbosity": "string",
          "logLockWaits": true,
          "logStatement": "string",
          "logTempFiles": "integer",
          "searchPath": "string",
          "rowSecurity": true,
          "defaultTransactionIsolation": "string",
          "statementTimeout": "integer",
          "lockTimeout": "integer",
          "idleInTransactionSessionTimeout": "integer",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "integer",
          "deadlockTimeout": "integer",
          "maxLocksPerTransaction": "integer",
          "maxPredLocksPerTransaction": "integer",
          "arrayNulls": true,
          "backslashQuote": "string",
          "defaultWithOids": true,
          "escapeStringWarning": true,
          "loCompatPrivileges": true,
          "operatorPrecedenceWarning": true,
          "quoteAllIdentifiers": true,
          "standardConformingStrings": true,
          "synchronizeSeqscans": true,
          "transformNullEquals": true,
          "exitOnError": true,
          "seqPageCost": "number",
          "randomPageCost": "number"
        },
        // конец списка возможных полей`hostSpecs.configSpec`

      }
    }
  ],
  "networkId": "string"
}
```

 
Поле | Описание
--- | ---
backupId | **string**<br>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос [listBackups](/docs/mdb/api-ref/postgresql/Cluster/listBackups).
time | **string** (date-time)<br>Обязательное поле. Момент времени, на который должен быть восстановлен кластер PostgreSQL.
timeInclusive | **boolean** (boolean)<br>Флаг, указывающий, должна ли база данных быть восстановлена до первой точки резервного копирования после момента [time](/docs/mdb/api-ref/postgresql/Cluster/restore#body_params), или до последней точки перед ним.  Возможные значения: * false (по умолчанию) — точкой восстановления является первая точка резервного копирования перед [time](/docs/mdb/api-ref/postgresql/Cluster/restore#body_params). * true — точкой восстановления является первая точка резервного копирования после [time](/docs/mdb/api-ref/postgresql/Cluster/restore#body_params).
name | **string**<br>Обязательное поле. Имя не может быть изменено после создания кластера PostgreSQL.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
description | **string**<br>Описание нового кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов.  Максимальная длина — 256 символов.
labels | **object**<br>Пользовательские метки для кластера PostgreSQL в виде пар ключ-значение. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary".  Не более 64 на ресурс.  Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.
environment | **string**<br>Среда развертывания для нового кластера PostgreSQL.   - PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.  - PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.<br>`PRODUCTION`<br>`PRESTABLE`<br>
configSpec | **object**<br>Конфигурация для создаваемого кластера PostgreSQL.
configSpec.<br>version | **string**<br>Версия PostgreSQL, используемая в кластере. Возможные значения: * 10 * 9.6
configSpec.<br>poolerConfig | **object**<br>
configSpec.<br>poolerConfig.<br>poolingMode | **string**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage).   - SESSION: Сессионный режим управления подключениями.  - TRANSACTION: Транзакционный режим управления подключениями.  - STATEMENT: Операторный режим управления подключениями.<br>`SESSION`<br>`TRANSACTION`<br>`STATEMENT`<br>
configSpec.<br>resources | **object**<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
configSpec.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
configSpec.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
configSpec.<br>autofailover | **boolean** (boolean)<br>Параметр конфигурации, который включает / отключает отказоустойчивость в кластере.
configSpec.<br>postgresqlConfig_9_6 | **object** <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/9.6/static/runtime-config).
configSpec.<br>postgresqlConfig_9_6.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
configSpec.<br>postgresqlConfig_9_6.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br>Эта настройка была удалена в PostgreSQL 10.
configSpec.<br>postgresqlConfig_10 | **object** <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/10/static/runtime-config).
configSpec.<br>postgresqlConfig_10.<br>maxConnections | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxPreparedTransactions | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maintenanceWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>autovacuumWorkMem | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostPageHit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostPageMiss | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostPageDirty | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>vacuumCostLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
configSpec.<br>postgresqlConfig_10.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
configSpec.<br>postgresqlConfig_10.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
configSpec.<br>postgresqlConfig_10.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
configSpec.<br>postgresqlConfig_10.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
hostSpecs | **object**<br>Обязательное поле. Конфигурации для хостов PostgreSQL, которые должны быть созданы для кластера, создаваемого из резервной копии.  Должен содержать хотя бы один элемент.
hostSpecs.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [list](/docs/compute/api-ref/Zone/list).  Максимальная длина — 50 символов.
hostSpecs.<br>subnetId | **string**<br>Идентификатор подсети, к которой принадлежит хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.networkId](/docs/mdb/api-ref/postgresql/Cluster#representation).  Максимальная длина — 50 символов.
hostSpecs.<br>assignPublicIp | **boolean** (boolean)<br>Должен ли хост получить публичный IP-адрес при создании.  После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля assignPublicIp.  Возможные значения: * false — не назначать хосту публичный IP-адрес. * true — у хоста должен быть публичный IP-адрес.
hostSpecs.<br>replicationSource | **string**<br>name of the host to be used as the replication source (for cascading replication).
hostSpecs.<br>priority | **integer** (int64)<br>Приоритет хоста как реплики. Большее значение соответствует более высокому приоритету.  Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.  Когда реплика становится мастером, ее приоритет игнорируется.
hostSpecs.<br>configSpec | **object**<br>Конфигурация сервера PostgreSQL для хоста.
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6 | **object** <br>`hostSpecs.configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [Документации PostgreSQL](https://www.postgresql.org/docs/9.6/static/runtime-config).
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br>Эта настройка была удалена в PostgreSQL 10.
hostSpecs.<br>configSpec.<br>postgresqlConfig_10 | **object** <br>`hostSpecs.configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/10/static/runtime-config).
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
networkId | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать PostgreSQL кластер.  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор операции.
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
createdBy | **string**<br>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.
modifiedAt | **string** (date-time)<br>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
done | **boolean** (boolean)<br>Только для вывода. Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.
metadata | **object**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.
error | **object** <br> включает только одно из полей `error`, `response`<br><br>Описание ошибки в случае сбоя или отмены операции.
error.<br>code | **integer** (int32)<br>Код ошибки. Значение из списка [google.rpc.Code](https://cloud.google.com/appengine/docs/admin-api/reference/rpc/google.rpc#google.rpc.Code).
error.<br>message | **string**<br>Текст ошибки.
error.<br>details | **object**<br>Список сообщений с подробными сведениями об ошибке.
response | **object** <br> включает только одно из полей `error`, `response`<br><br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.