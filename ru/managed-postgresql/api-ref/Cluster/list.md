# Метод list
Получает список ресурсов Cluster для PostgreSQL, принадлежащих
указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для вывода списка кластеров PostgreSQL. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-postgresql/api-ref/Cluster/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-postgresql/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-postgresql/api-ref/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/managed-postgresql/api-ref/Cluster/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](/docs/managed-postgresql/api-ref/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
clusters | **object**<br><p>Ресурс Cluster для PostgreSQL. Подробнее см. <a href="/docs/managed-postgresql/concepts">документацию MDB</a> в руководстве разработчика.</p> 
clusters.<br>id | **string**<br><p>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании.</p> 
clusters.<br>folderId | **string**<br><p>Идентификатор папки, которой принадлежит кластер PostgreSQL.</p> 
clusters.<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters.<br>name | **string**<br><p>Имя кластера PostgreSQL. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
clusters.<br>description | **string**<br><p>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов.</p> 
clusters.<br>labels | **object**<br><p>Пользовательские метки для кластера PostgreSQL как пары <code>key:value</code>. Максимум 64 на ресурс.</p> 
clusters.<br>environment | **string**<br><p>Среда развертывания для кластера PostgreSQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters.<br>monitoring | **object**<br><p>Система мониторинга.</p> 
clusters.<br>monitoring.<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters.<br>monitoring.<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters.<br>monitoring.<br>link | **string**<br><p>Ссылка на графики системы мониторинга для данного кластера PostgreSQL.</p> 
clusters.<br>config | **object**<br><p>Конфигурация кластера PostgreSQL.</p> 
clusters.<br>config.<br>version | **string**<br><p>Версия серверного программного обеспечения PostgreSQL.</p> 
clusters.<br>config.<br>poolerConfig | **object**<br>
clusters.<br>config.<br>poolerConfig.<br>poolingMode | **string**<br><p>Режим, в котором работает менеджер подключений. См. описание всех режимов в <a href="https://pgbouncer.github.io/usage">документации PgBouncer</a>.</p> <ul> <li>SESSION: Сессионный режим управления подключениями.</li> <li>TRANSACTION: Транзакционный режим управления подключениями.</li> <li>STATEMENT: Операторный режим управления подключениями.</li> </ul> 
clusters.<br>config.<br>resources | **object**<br>
clusters.<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-postgresql/concepts/instance-types">документации</a>.</p> 
clusters.<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступный хосту, в байтах.</p> 
clusters.<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-nvme — сетевой SSD-диск;</li> <li>local-nvme — локальное SSD-хранилище.</li> </ul> 
clusters.<br>config.<br>autofailover | **boolean** (boolean)<br><p>Параметр конфигурации, который включает / отключает отказоустойчивость в кластере.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6 | **object** <br>`clusters.config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера PostgreSQL 9.6 (сочетание настроек, определенных в userConfig и [default_config]).</p> <p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>searchPath | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>byteaOutput | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmlbinary | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmloption | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backslashQuote | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 9.6.</p> <p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>workMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>forceParallelMode | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>clientMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinErrorStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logErrorVerbosity | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>searchPath | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>byteaOutput | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmlbinary | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmloption | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backslashQuote | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>seqPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>randomPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 9.6.</p> <p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>forceParallelMode | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>clientMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>searchPath | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>byteaOutput | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmlbinary | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmloption | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backslashQuote | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
clusters.<br>config.<br>postgresqlConfig_10 | **object** <br>`clusters.config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig | **object**<br><p>Обязательное поле. Действующие настройки для кластера PostgreSQL 10 (сочетание настроек, определенных в userConfig и [default_config]).</p> <p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>sharedBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>workMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>replacementSortTuples | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>tempFileLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>vacuumCostLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>searchPath | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>byteaOutput | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmlbinary | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmloption | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backslashQuote | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultWithOids | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>transformNullEquals | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>exitOnError | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>seqPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>randomPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера PostgreSQL 10.</p> <p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxConnections | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>sharedBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>tempBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>workMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>replacementSortTuples | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>tempFileLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>vacuumCostLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>forceParallelMode | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>clientMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinErrorStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logErrorVerbosity | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>searchPath | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>byteaOutput | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>xmlbinary | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>xmloption | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>backslashQuote | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultWithOids | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>transformNullEquals | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>exitOnError | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>seqPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>randomPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера PostgreSQL 10.</p> <p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>sharedBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempBuffers | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>workMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maintenanceWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>replacementSortTuples | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>autovacuumWorkMem | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>tempFileLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageHit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageMiss | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostPageDirty | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>vacuumCostLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>forceParallelMode | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>clientMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinMessages | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logStatement | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>searchPath | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>byteaOutput | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmlbinary | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmloption | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backslashQuote | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultWithOids | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>escapeStringWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>loCompatPrivileges | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>standardConformingStrings | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronizeSeqscans | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>transformNullEquals | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>exitOnError | **boolean** (boolean)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>seqPageCost | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>randomPageCost | **number** (double)<br>
clusters.<br>networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
clusters.<br>health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно ([Host.health] для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально ([Host.health] для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает ([Host.health] для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально ([Host.health] по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
clusters.<br>status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-postgresql/api-ref/Cluster/list#query_params">pageSize</a>, используйте <a href="/docs/managed-postgresql/api-ref/Cluster/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-postgresql/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-postgresql/api-ref/Cluster/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 
