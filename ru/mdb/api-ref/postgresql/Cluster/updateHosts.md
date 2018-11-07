# Метод updateHosts
Обновляет указанные хосты.
 

 
## HTTP-запрос {#https-request}
`POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/hosts:batchUpdate`
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL, в котором нужно изменить хосты. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [list](/docs/mdb/api-ref/postgresql/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "updateHostSpecs": [
    {
      "hostName": "string",
      "replicationSource": "string",
      "priority": "integer",
      "configSpec": {

        // `updateHostSpecs.configSpec`включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`
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
        // конец списка возможных полей`updateHostSpecs.configSpec`

      }
    }
  ]
}
```

 
Поле | Описание
--- | ---
updateHostSpecs | **object**<br><p>Обязательное поле. Новые конфигурации, которые следует применить к хостам.</p> <p>Должен содержать хотя бы один элемент.</p> 
updateHostSpecs.<br>hostName | **string**<br><p>Обязательное поле. Имя хоста, который следует обновить. Чтобы получить имя хоста PostgreSQL, используйте запрос <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts">listHosts</a>.</p> 
updateHostSpecs.<br>replicationSource | **string**<br><p>name хоста, который будет использоваться в качестве источника репликации (для каскадной репликации). Чтобы получить имя хоста PostgreSQL, используйте запрос <a href="/docs/mdb/api-ref/postgresql/Cluster/listHosts">listHosts</a>.</p> 
updateHostSpecs.<br>priority | **integer** (int64)<br><p>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер.</p> <p>Когда реплика становится мастером, ее приоритет игнорируется.</p> 
updateHostSpecs.<br>configSpec | **object**<br><p>Конфигурация сервера PostgreSQL для хоста.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6 | **object** <br>`updateHostSpecs.configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlHostConfig</code> отражает параметры конфигурационного файла PostgreSQL. Подробное описание доступно в <a href="https://www.postgresql.org/docs/9.6/static/runtime-config.html">документации PostgreSQL</a>.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>workMem | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>constraintExclusion | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>forceParallelMode | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>clientMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinErrorStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logErrorVerbosity | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>searchPath | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>byteaOutput | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmlbinary | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>xmloption | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>backslashQuote | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>seqPageCost | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>randomPageCost | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_9_6.<br>sqlInheritance | **boolean** (boolean)<br><p>Эта настройка была удалена в PostgreSQL 10.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10 | **object** <br>`updateHostSpecs.configSpec` включает только одно из полей `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br><p>Поля и структура <code>PostgresqlHostConfig</code> отражает параметры конфигурационного файла PostgreSQL, подробное описание которого доступно в <a href="https://www.postgresql.org/docs/10/static/runtime-config">документации PostgreSQL</a>.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>recoveryMinApplyDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>sharedBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempBuffers | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>workMem | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>replacementSortTuples | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>tempFileLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backendFlushAfter | **integer** (int64)<br><p>Допустимые значения — от 0 до 2048 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Допустимые значения — от -1 до 86400 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>constraintExclusion | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>cursorTupleFraction | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>fromCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>joinCollapseLimit | **integer** (int64)<br><p>Допустимые значения — от 1 до 2147483647 включительно.</p> 
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>forceParallelMode | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>clientMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinMessages | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinErrorStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logMinDurationStatement | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logCheckpoints | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logConnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDisconnections | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logDuration | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logErrorVerbosity | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logLockWaits | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logStatement | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>logTempFiles | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>searchPath | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>rowSecurity | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultTransactionIsolation | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>statementTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>lockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>byteaOutput | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmlbinary | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>xmloption | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>ginPendingListLimit | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>deadlockTimeout | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>arrayNulls | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>backslashQuote | **string**<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>defaultWithOids | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>escapeStringWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>loCompatPrivileges | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>operatorPrecedenceWarning | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>quoteAllIdentifiers | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>standardConformingStrings | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>synchronizeSeqscans | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>transformNullEquals | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>exitOnError | **boolean** (boolean)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>seqPageCost | **number** (double)<br>
updateHostSpecs.<br>configSpec.<br>postgresqlConfig_10.<br>randomPageCost | **number** (double)<br>
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Только для вывода. Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 