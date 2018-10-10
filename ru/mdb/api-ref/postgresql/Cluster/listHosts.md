# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос
`GET /managed-postgresql/v1/clusters/{clusterId}/hosts`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
hosts | **object**<br>Список ресурсов Host.
hosts.<br>name | **string**<br>Имя хоста PostgreSQL. Имя хоста назначается MDB во время создания и не может быть изменено. Длина имени должна быть от 1 до 63 символов.  Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.
hosts.<br>clusterId | **string**<br>Идентификатор хоста PostgreSQL. Этот идентификатор генерирует MDB при создании.
hosts.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост PostgreSQL.
hosts.<br>resources | **object**<br>Ресурсы, выделенные для хоста PostgreSQL.
hosts.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
hosts.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
hosts.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
hosts.<br>role | **string**<br>Роль хоста в кластере.   - MASTER: Хост является мастером кластере в кластере PostgreSQL.  - REPLICA: Хост является репликой в кластере PostgreSQL.<br>`ROLE_UNKNOWN`<br>`MASTER`<br>`REPLICA`<br>
hosts.<br>health | **string**<br>Код работоспособности хоста.   - ALIVE: Хост выполняет все свои функции в нормальном режиме.  - DEAD: Хост не работает и не может выполнять свои основные функции.  - DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>`DEGRADED`<br>
hosts.<br>services | **object**<br>Сервисы, предоставляемые хостом.
hosts.<br>services.<br>type | **string**<br>Тип сервиса, предоставляемого хостом.   - POSTGRES: Данный хост — это сервер PostgreSQL.  - POOLER: Данный хост — это сервер PgBouncer.<br>`POSTGRES`<br>`POOLER`<br>
hosts.<br>services.<br>health | **string**<br>Код состояния доступности сервера.   - ALIVE: Сервер работает нормально.  - DEAD: Сервер отключен или не отвечает.<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>
hosts.<br>subnetId | **string**<br>Идентификатор подсети, к которой принадлежит хост.
hosts.<br>replicationSource | **string**<br>name of the host to be used as the replication source for cascading replication.
hosts.<br>priority | **integer** (int64)<br>Приоритет хоста как реплики. Более высокое значение соответствует более высокому приоритету.  Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.  Когда реплика становится мастером, ее приоритет игнорируется.
hosts.<br>config | **object**<br>Конфигурация сервера PostgreSQL для хоста.
hosts.<br>config.<br>postgresqlConfig_9_6 | **object** <br>`hosts.config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [Документации PostgreSQL](https://www.postgresql.org/docs/9.6/static/runtime-config).
hosts.<br>config.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
hosts.<br>config.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
hosts.<br>config.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hosts.<br>config.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hosts.<br>config.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br>Эта настройка была удалена в PostgreSQL 10.
hosts.<br>config.<br>postgresqlConfig_10 | **object** <br>`hosts.config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>Поля и структура `PostgresqlConfig` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в [документации PostgreSQL](https://www.postgresql.org/docs/10/static/runtime-config).
hosts.<br>config.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br>Допустимые значения — от 0 до 2048 включительно.
hosts.<br>config.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br>Допустимые значения — от -1 до 86400 включительно.
hosts.<br>config.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br><br>`CONSTRAINT_EXCLUSION_ON`<br>`CONSTRAINT_EXCLUSION_OFF`<br>`CONSTRAINT_EXCLUSION_PARTITION`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hosts.<br>config.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br>Допустимые значения — от 1 до 2147483647 включительно.
hosts.<br>config.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br><br>`FORCE_PARALLEL_MODE_ON`<br>`FORCE_PARALLEL_MODE_OFF`<br>`FORCE_PARALLEL_MODE_REGRESS`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br><br>`LOG_LEVEL_DEBUG5`<br>`LOG_LEVEL_DEBUG4`<br>`LOG_LEVEL_DEBUG3`<br>`LOG_LEVEL_DEBUG2`<br>`LOG_LEVEL_DEBUG1`<br>`LOG_LEVEL_LOG`<br>`LOG_LEVEL_NOTICE`<br>`LOG_LEVEL_WARNING`<br>`LOG_LEVEL_ERROR`<br>`LOG_LEVEL_FATAL`<br>`LOG_LEVEL_PANIC`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br><br>`LOG_ERROR_VERBOSITY_TERSE`<br>`LOG_ERROR_VERBOSITY_DEFAULT`<br>`LOG_ERROR_VERBOSITY_VERBOSE`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logStatement | **string**<br><br>`LOG_STATEMENT_NONE`<br>`LOG_STATEMENT_DDL`<br>`LOG_STATEMENT_MOD`<br>`LOG_STATEMENT_ALL`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br><br>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`<br>`TRANSACTION_ISOLATION_READ_COMMITTED`<br>`TRANSACTION_ISOLATION_REPEATABLE_READ`<br>`TRANSACTION_ISOLATION_SERIALIZABLE`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br><br>`BYTEA_OUTPUT_HEX`<br>`BYTEA_OUTPUT_ESCAPED`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br><br>`XML_BINARY_BASE64`<br>`XML_BINARY_HEX`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>xmloption | **string**<br><br>`XML_OPTION_DOCUMENT`<br>`XML_OPTION_CONTENT`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br><br>`BACKSLASH_QUOTE`<br>`BACKSLASH_QUOTE_ON`<br>`BACKSLASH_QUOTE_OFF`<br>`BACKSLASH_QUOTE_SAFE_ENCODING`<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params), используйте [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses) для перебора страниц результатов.