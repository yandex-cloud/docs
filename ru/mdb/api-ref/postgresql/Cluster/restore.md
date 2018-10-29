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
backupId | **string**<br><p>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос <a href="/docs/mdb/api-ref/postgresql/Cluster/listBackups">listBackups</a>.</p> 
time | **string** (date-time)<br><p>Обязательное поле. Момент времени, на который должен быть восстановлен кластер PostgreSQL.</p> 
timeInclusive | **boolean** (boolean)<br><p>Флаг, указывающий, должна ли база данных быть восстановлена до первой точки резервного копирования после момента <a href="/docs/mdb/api-ref/postgresql/Cluster/restore#body_params">time</a>, или до последней точки перед ним.</p> <p>Возможные значения:</p> <ul> <li>false (по умолчанию) — точкой восстановления является первая точка резервного копирования перед <a href="/docs/mdb/api-ref/postgresql/Cluster/restore#body_params">time</a>.</li> <li>true — точкой восстановления является первая точка резервного копирования после <a href="/docs/mdb/api-ref/postgresql/Cluster/restore#body_params">time</a>.</li> </ul> 
name | **string**<br><p>Обязательное поле. Имя не может быть изменено после создания кластера PostgreSQL.</p> <p>Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению <code>^[a-z][-a-z0-9]{1,61}[a-z0-9]$</code>.</p> 
description | **string**<br><p>Описание нового кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов.</p> <p>Максимальная длина — 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера PostgreSQL в виде пар <code>ключ:значение</code>. Максимум 64 на ресурс. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Среда развертывания для нового кластера PostgreSQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Конфигурация для создаваемого кластера PostgreSQL.</p> 
configSpec.<br>version | **string**<br><p>Версия PostgreSQL, используемая в кластере. Возможные значения:</p> <ul> <li>10</li> <li>9.6</li> </ul> 
configSpec.<br>poolerConfig | **object**<br>
configSpec.<br>poolerConfig.<br>poolingMode | **string**<br><p>Режим, в котором работает менеджер подключений. См. описание всех режимов в <a href="https://pgbouncer.github.io/usage">документации PgBouncer</a>.</p> <ul> <li>SESSION: Сессионный режим управления подключениями.</li> <li>TRANSACTION: Транзакционный режим управления подключениями.</li> <li>STATEMENT: Операторный режим управления подключениями.</li> </ul> 
configSpec.<br>resources | **object**<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/mdb/concepts/instance-types">Классы хостов</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступный хосту, в байтах.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>local-ssd — хранилище на базе локальных SSD-дисков.</li> </ul> 
configSpec.<br>autofailover | **boolean** (boolean)<br><p>Параметр конфигурации, который включает / отключает отказоустойчивость в кластере.</p> 
configSpec.<br>postgresqlConfig_9_6 | **object** <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
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
configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
configSpec.<br>postgresqlConfig_10 | **object** <br>`configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
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
configSpec.<br>postgresqlConfig_10.<br>bgwriterDelay | **integer** (int64)<br><p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMaxpages | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterLruMultiplier | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>walLevel | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>synchronousCommit | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointTimeout | **integer** (int64)<br><p>Допустимые значения — от 30 до 86400 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>checkpointCompletionTarget | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>checkpointFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>maxWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>minWalSize | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultStatisticsTarget | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
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
hostSpecs | **object**<br><p>Обязательное поле. Конфигурации для хостов PostgreSQL, которые должны быть созданы для кластера, создаваемого из резервной копии.</p> <p>Должен содержать хотя бы один элемент.</p> 
hostSpecs.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина — 50 символов.</p> 
hostSpecs.<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле <a href="/docs/mdb/api-ref/postgresql/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина — 50 символов.</p> 
hostSpecs.<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля assignPublicIp.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
hostSpecs.<br>replicationSource | **string**<br><p>name of the host to be used as the replication source (for cascading replication).</p> 
hostSpecs.<br>priority | **integer** (int64)<br><p>Приоритет хоста как реплики. Большее значение соответствует более высокому приоритету.</p> <p>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.</p> <p>Когда реплика становится мастером, ее приоритет игнорируется.</p> 
hostSpecs.<br>configSpec | **object**<br><p>Конфигурация сервера PostgreSQL для хоста.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6 | **object** <br>`hostSpecs.configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">Документации PostgreSQL</a>.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
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
hostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_10 | **object** <br>`hostSpecs.configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
hostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
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
networkId | **string**<br><p>Обязательное поле. Идентификатор сети, в которой нужно создать PostgreSQL кластер.</p> <p>Максимальная длина — 50 символов.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 