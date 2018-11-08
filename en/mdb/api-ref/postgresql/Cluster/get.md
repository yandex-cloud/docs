# Method get
Returns the specified PostgreSQL Cluster resource.
 
To get the list of available PostgreSQL Cluster resources, make a [list](/docs/mdb/api-ref/postgresql/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL Cluster resource to return. To get the cluster ID use a [list](/docs/mdb/api-ref/postgresql/Cluster/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

A PostgreSQL Cluster resource. For more information, see the [Cluster](/docs/mdb/concepts) section
in the Developer's Guide.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the PostgreSQL cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the PostgreSQL cluster. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the PostgreSQL cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the PostgreSQL cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the PostgreSQL cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring | **object**<br><p>Monitoring system.</p> 
monitoring.<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring.<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring.<br>link | **string**<br><p>Link to the monitoring system charts for the PostgreSQL cluster.</p> 
config | **object**<br><p>Configuration of the PostgreSQL cluster.</p> 
config.<br>version | **string**<br><p>Version of PostgreSQL server software.</p> 
config.<br>poolerConfig | **object**<br>
config.<br>poolerConfig.<br>poolingMode | **string**<br><p>Mode that the connection pooler is working in. See descriptions of all modes in the <a href="https://pgbouncer.github.io/usage">documentation for PgBouncer</a>.</p> <ul> <li>SESSION: Session pooling mode.</li> <li>TRANSACTION: Transaction pooling mode.</li> <li>STATEMENT: Statement pooling mode.</li> </ul> 
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/mdb/concepts/instance-types">documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
config.<br>autofailover | **boolean** (boolean)<br><p>Configuration setting which enables/disables autofailover in cluster.</p> 
config.<br>postgresqlConfig_9_6 | **object** <br>`config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 9.6 cluster (a combination of settings defined in userConfig and [default_config]).</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backslashQuote | **string**<br>
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
config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 9.6 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backslashQuote | **string**<br>
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
config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 9.6 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backslashQuote | **string**<br>
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
config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
config.<br>postgresqlConfig_10 | **object** <br>`config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
config.<br>postgresqlConfig_10.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 10 cluster (a combination of settings defined in userConfig and [default_config]).</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backslashQuote | **string**<br>
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
config.<br>postgresqlConfig_10.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 10 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>userConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>userConfig.<br>backslashQuote | **string**<br>
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
config.<br>postgresqlConfig_10.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 10 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>walLevel | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronousCommit | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>constraintExclusion | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>forceParallelMode | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>clientMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinMessages | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinErrorStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logMinDurationStatement | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logCheckpoints | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logConnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDisconnections | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logDuration | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logErrorVerbosity | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logLockWaits | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logStatement | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>logTempFiles | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>searchPath | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>rowSecurity | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultTransactionIsolation | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>statementTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>lockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>idleInTransactionSessionTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>byteaOutput | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmlbinary | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>xmloption | **string**<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>ginPendingListLimit | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>deadlockTimeout | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxPredLocksPerTransaction | **integer** (int64)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>arrayNulls | **boolean** (boolean)<br>
config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backslashQuote | **string**<br>
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
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown ([Host.health] for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well ([Host.health] for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable ([Host.health] for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity ([Host.health] for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> </ul> 