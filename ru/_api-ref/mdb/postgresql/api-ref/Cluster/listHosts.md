---
editable: false
---

# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/managed-postgresql/api-ref/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/managed-postgresql/api-ref/Cluster/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "role": "string",
      "health": "string",
      "services": [
        {
          "type": "string",
          "health": "string"
        }
      ],
      "subnetId": "string",
      "replicationSource": "string",
      "priority": "integer",
      "config": {

        // `hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`
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
        "postgresqlConfig_10_1C": {
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
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
          "randomPageCost": "number",
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer"
        },
        "postgresqlConfig_11": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer"
        },
        "postgresqlConfig_11_1C": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer"
        },
        "postgresqlConfig_12": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        "postgresqlConfig_12_1C": {
          "recoveryMinApplyDelay": "integer",
          "sharedBuffers": "integer",
          "tempBuffers": "integer",
          "workMem": "integer",
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
          "enableBitmapscan": true,
          "enableHashagg": true,
          "enableHashjoin": true,
          "enableIndexscan": true,
          "enableIndexonlyscan": true,
          "enableMaterial": true,
          "enableMergejoin": true,
          "enableNestloop": true,
          "enableSeqscan": true,
          "enableSort": true,
          "enableTidscan": true,
          "maxParallelWorkers": "integer",
          "maxParallelWorkersPerGather": "integer",
          "timezone": "string",
          "effectiveIoConcurrency": "integer",
          "effectiveCacheSize": "integer"
        },
        // конец списка возможных полей`hosts[].config`

      },
      "assignPublicIp": true,
      "replicaType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Список ресурсов Host.</p> 
hosts[].<br>name | **string**<br><p>Имя хоста PostgreSQL. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов.</p> <p>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts[].<br>clusterId | **string**<br><p>Идентификатор хоста PostgreSQL. Этот идентификатор генерирует MDB при создании.</p> 
hosts[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост PostgreSQL.</p> 
hosts[].<br>resources | **object**<br><p>Ресурсы, выделенные для хоста PostgreSQL.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-postgresql/concepts/instance-types">документации</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
hosts[].<br>role | **string**<br><p>Роль хоста в кластере.</p> <ul> <li>ROLE_UNKNOWN: Роль хоста в кластере неизвестна.</li> <li>MASTER: Хост является мастером в кластере PostgreSQL.</li> <li>REPLICA: Хост является репликой в кластере PostgreSQL.</li> </ul> 
hosts[].<br>health | **string**<br><p>Код работоспособности хоста.</p> <ul> <li>HEALTH_UNKNOWN: Состояние хоста неизвестно.</li> <li>ALIVE: Хозяин выполняет все свои функции нормально.</li> <li>DEAD: Хост не работает и не может выполнять свои основные функции.</li> <li>DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Сервисы, предоставляемые хостом.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>POSTGRESQL: Данный хост — это сервер PostgreSQL.</li> <li>POOLER: Данный хост — это сервер PgBouncer.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Код состояния доступности сервера.</p> <ul> <li>HEALTH_UNKNOWN: Работоспособность сервера неизвестна.</li> <li>ALIVE: Сервер работает нормально.</li> <li>DEAD: Сервер отключен или не отвечает.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост.</p> 
hosts[].<br>replicationSource | **string**<br><p>Имя хоста, который будет использоваться в качестве источника репликации (для каскадной репликации).</p> 
hosts[].<br>priority | **integer** (int64)<br><p>Приоритет хоста как реплики. Более высокое значение соответствует более высокому приоритету.</p> <p>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.</p> <p>Когда реплика становится мастером, ее приоритет игнорируется.</p> 
hosts[].<br>config | **object**<br><p>Конфигурация сервера PostgreSQL для хоста.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6 | **object**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlHostConfig`` отражает параметры конфигурационного файла PostgreSQL. Подробное описание доступно в <a href="https://www.postgresql.org/docs/9.6/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена с выходом PostgreSQL 10.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlHostConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>replacementSortTuples | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableHashagg | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableHashjoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableIndexscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableMaterial | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableMergejoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableNestloop | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableSeqscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableSort | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>enableTidscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>timezone | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10 | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlHostConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableBitmapscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableHashagg | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableHashjoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableIndexscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableMaterial | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableMergejoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableNestloop | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableSeqscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableSort | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>enableTidscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_10.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11 | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableBitmapscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableHashagg | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableHashjoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableIndexscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableMaterial | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableMergejoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableNestloop | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableSeqscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableSort | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>enableTidscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableHashagg | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableHashjoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableIndexscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableMaterial | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableMergejoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableNestloop | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableSeqscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableSort | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>enableTidscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_11_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12 | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableBitmapscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableHashagg | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableHashjoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableIndexscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableMaterial | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableMergejoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableNestloop | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableSeqscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableSort | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>enableTidscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>timezone | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C | **object**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. <br>`hosts[].config` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10_1C`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1C`, `postgresqlConfig_12`, `postgresqlConfig_12_1C`<br><br><p>Поля и структура ``PostgresqlConfig`` отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/11/runtime-config.html">документации PostgreSQL</a>.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>sharedBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>tempBuffers | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>workMem | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>tempFileLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>constraintExclusion | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>cursorTupleFraction | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>forceParallelMode | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>clientMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logMinMessages | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logMinErrorStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logMinDurationStatement | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logCheckpoints | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logConnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logDisconnections | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logDuration | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logErrorVerbosity | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logLockWaits | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logStatement | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>logTempFiles | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>searchPath | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>rowSecurity | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultTransactionIsolation | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>statementTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>lockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>byteaOutput | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>xmlbinary | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>xmloption | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>ginPendingListLimit | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>deadlockTimeout | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>arrayNulls | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>backslashQuote | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>defaultWithOids | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>escapeStringWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>loCompatPrivileges | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>standardConformingStrings | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>synchronizeSeqscans | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>transformNullEquals | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>exitOnError | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>seqPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>randomPageCost | **number** (double)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableBitmapscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableHashagg | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableHashjoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableIndexscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableIndexonlyscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableMaterial | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableMergejoin | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableNestloop | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableSeqscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableSort | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>enableTidscan | **boolean** (boolean)<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxParallelWorkers | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>maxParallelWorkersPerGather | **integer** (int64)<br><p>Допустимые значения — от 0 до 1024 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>timezone | **string**<br>
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveIoConcurrency | **integer** (int64)<br><p>Допустимые значения — от 0 до 1000 включительно.</p> 
hosts[].<br>config.<br>postgresqlConfig_12_1C.<br>effectiveCacheSize | **integer** (int64)<br><p>Допустимые значения — от 0 до 549755813888 включительно.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, показывающий статус публичного IP-адреса для этого хоста.</p> 
hosts[].<br>replicaType | **string**<br>
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params">pageSize</a>, используйте <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-postgresql/api-ref/Cluster/listHosts#responses">nextPageToken</a> для перебора страниц результатов.</p> 