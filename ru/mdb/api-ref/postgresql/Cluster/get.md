# Метод get
Возвращает указанный ресурс Cluster для PostgreSQL.
 
Чтобы получить список доступных ресурсов Cluster для PostgreSQL,
отправьте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).
 
## HTTP-запрос
`GET /managed-postgresql/v1/clusters/{clusterId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор возвращаемого ресурса Cluster для PostgreSQL. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Cluster для PostgreSQL. Подробнее см. раздел [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts) в
руководстве разработчика.
 
Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании.
folderId | **string**<br>Идентификатор папки, которой принадлежит кластер PostgreSQL.
createdAt | **string** (date-time)<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
name | **string**<br>Имя кластера PostgreSQL. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов.
labels | **object**<br>Пользовательские метки для кластера PostgreSQL в виде пар ключ-значение. Максимум 64 на ресурс.
environment | **string**<br>Среда развертывания для кластера PostgreSQL.   - PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.  - PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.<br>`PRODUCTION`<br>`PRESTABLE`<br>
monitoring | **object**<br>Система мониторинга.
monitoring.<br>name | **string**<br>Название системы мониторинга.
monitoring.<br>description | **string**<br>Описание системы мониторинга.
monitoring.<br>link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL.
config | **object**<br>Конфигурация кластера PostgreSQL.
config.<br>version | **string**<br>Версия серверного программного обеспечения PostgreSQL.
config.<br>poolerConfig | **object**<br>
config.<br>poolerConfig.<br>poolingMode | **string**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage).   - SESSION: Сессионный режим управления подключениями.  - TRANSACTION: Транзакционный режим управления подключениями.  - STATEMENT: Операторный режим управления подключениями.<br>`SESSION`<br>`TRANSACTION`<br>`STATEMENT`<br>
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
config.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
config.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
config.<br>autofailover | **boolean** (boolean)<br>Параметр конфигурации, который включает / отключает отказоустойчивость в кластере.
config.<br>postgresqlConfig_9_6 | **object** <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig | **object**<br>Обязательное поле. Действующие настройки для кластера PostgreSQL 9.6 (сочетание настроек, определенных в userConfig и [default_config]).  Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/9.6/static/runtime-config).
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sqlInheritance | **boolean** (boolean)<br>Эта настройка была удалена в PostgreSQL 10.
config.<br>postgresqlConfig_9_6.<br>userConfig | **object**<br>Пользовательские настройки для кластера PostgreSQL 9.6.  Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/9.6/static/runtime-config).
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sqlInheritance | **boolean** (boolean)<br>Эта настройка была удалена в PostgreSQL 10.
config.<br>postgresqlConfig_9_6.<br>defaultConfig | **object**<br>Конфигурация по умолчанию для кластера PostgreSQL 9.6.  Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/9.6/static/runtime-config).
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sqlInheritance | **boolean** (boolean)<br>Эта настройка была удалена в PostgreSQL 10.
config.<br>postgresqlConfig_10 | **object** <br>`config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
config.<br>postgresqlConfig_10.<br>effectiveConfig | **object**<br>Обязательное поле. Действующие настройки для кластера PostgreSQL 10 (сочетание настроек, определенных в userConfig и [default_config]).  Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/10/static/runtime-config).
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig | **object**<br>Пользовательские настройки для кластера PostgreSQL 10.  Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/10/static/runtime-config).
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_10.<br>userConfig.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>randomPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig | **object**<br>Конфигурация по умолчанию для кластера PostgreSQL 10.  Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/10/static/runtime-config).
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br>Допустимые значения — от 10 до 10000 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>walLevel | **string**<br><br>`WAL_LEVEL_REPLICA`<br>`WAL_LEVEL_LOGICAL`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronousCommit | **string**<br><br>`SYNCHRONOUS_COMMIT_ON`<br>`SYNCHRONOUS_COMMIT_OFF`<br>`SYNCHRONOUS_COMMIT_LOCAL`<br>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`<br>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br>Допустимые значения — от 30 до 86400 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
networkId | **string**<br>Идентификатор сети, к которой принадлежит кластер.
health | **string**<br>Агрегированная работоспособность кластера.   - HEALTH_UNKNOWN: Состояние кластера неизвестно ([Host.health] для каждого хоста в кластере — UNKNOWN).  - ALIVE: Кластер работает нормально ([Host.health] для каждого хоста в кластере — ALIVE).  - DEAD: Кластер не работает ([Host.health] для каждого узла в кластере — DEAD).  - DEGRADED: Кластер работает неоптимально ([Host.health] по крайней мере для одного узла в кластере не ALIVE).<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>`DEGRADED`<br>
status | **string**<br>Текущее состояние кластера.   - STATUS_UNKNOWN: Состояние кластера неизвестно.  - CREATING: Кластер создается.  - RUNNING: Кластер работает нормально.  - ERROR: На кластере произошла ошибка, блокирующая работу.<br>`STATUS_UNKNOWN`<br>`CREATING`<br>`RUNNING`<br>`ERROR`<br>