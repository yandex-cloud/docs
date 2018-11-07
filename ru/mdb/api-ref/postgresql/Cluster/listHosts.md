# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/hosts`
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
hosts | **object**<br><p>Список ресурсов Host.</p> 
hosts.<br>name | **string**<br><p>Имя хоста PostgreSQL. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов.</p> <p>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts.<br>clusterId | **string**<br><p>Идентификатор хоста PostgreSQL. Этот идентификатор генерирует MDB при создании.</p> 
hosts.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост PostgreSQL.</p> 
hosts.<br>resources | **object**<br><p>Ресурсы, выделенные для хоста PostgreSQL.</p> 
hosts.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/mdb/concepts/instance-types">документации</a>.</p> 
hosts.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступный хосту, в байтах.</p> 
hosts.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-nvme — сетевой SSD-диск;</li> <li>local-nvme — локальное SSD-хранилище.</li> </ul> 
hosts.<br>role | **string**<br><p>Роль хоста в кластере.</p> <ul> <li>ROLE_UNKNOWN: Роль хоста в кластере неизвестна.</li> <li>MASTER: Хост является мастером кластере в кластере PostgreSQL.</li> <li>REPLICA: Хост является репликой в кластере PostgreSQL.</li> </ul> 
hosts.<br>health | **string**<br><p>Код работоспособности хоста.</p> <ul> <li>HEALTH_UNKNOWN: Состояние хоста неизвестно.</li> <li>ALIVE: Хост выполняет все свои функции в нормальном режиме.</li> <li>DEAD: Хост не работает и не может выполнять свои основные функции.</li> <li>DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li> </ul> 
hosts.<br>services | **object**<br><p>Сервисы, предоставляемые хостом.</p> 
hosts.<br>services.<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>POSTGRESQL: Данный хост — это сервер PostgreSQL.</li> <li>POOLER: Данный хост — это сервер PgBouncer.</li> </ul> 
hosts.<br>services.<br>health | **string**<br><p>Код состояния доступности сервера.</p> <ul> <li>HEALTH_UNKNOWN: Работоспособность сервера неизвестна.</li> <li>ALIVE: Сервер работает нормально.</li> <li>DEAD: Сервер отключен или не отвечает.</li> </ul> 
hosts.<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост.</p> 
hosts.<br>replicationSource | **string**<br><p>name хоста, который будет использоваться в качестве источника репликации (для каскадной репликации).</p> 
hosts.<br>priority | **integer** (int64)<br><p>Приоритет хоста как реплики. Более высокое значение соответствует более высокому приоритету.</p> <p>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.</p> <p>Когда реплика становится мастером, ее приоритет игнорируется.</p> 
hosts.<br>config | **object**<br><p>Конфигурация сервера PostgreSQL для хоста.</p> 
hosts.<br>config.<br>postgresqlConfig_9_6 | **object** <br>`hosts.config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlHostConfig</code> отражает параметры конфигурационного файла PostgreSQL. Подробное описание доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts.<br>config.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
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
hosts.<br>config.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
hosts.<br>config.<br>postgresqlConfig_10 | **object** <br>`hosts.config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlHostConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
hosts.<br>config.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts.<br>config.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
hosts.<br>config.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
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
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts#responses">nextPageToken</a> для перебора страниц результатов.</p> 