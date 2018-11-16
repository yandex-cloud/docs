# Method list
Retrieves the list of PostgreSQL Cluster resources that belong
to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list PostgreSQL clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/mdb/api-ref/postgresql/Cluster/list#query_params), the service returns a [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/mdb/api-ref/postgresql/Cluster/list#query_params) to the [nextPageToken](/docs/mdb/api-ref/postgresql/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/mdb/api-ref/postgresql/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 3-63 characters long and match the regular expression `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**


 
Field | Description
--- | ---
clusters | **object**<br><p>A PostgreSQL Cluster resource. For more information, see the <a href="/docs/mdb/concepts">Cluster</a> section in the Developer's Guide.</p> 
clusters.<br>id | **string**<br><p>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time.</p> 
clusters.<br>folderId | **string**<br><p>ID of the folder that the PostgreSQL cluster belongs to.</p> 
clusters.<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters.<br>name | **string**<br><p>Name of the PostgreSQL cluster. The name is unique within the folder. 3-63 characters long.</p> 
clusters.<br>description | **string**<br><p>Description of the PostgreSQL cluster. 0-256 characters long.</p> 
clusters.<br>labels | **object**<br><p>Custom labels for the PostgreSQL cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
clusters.<br>environment | **string**<br><p>Deployment environment of the PostgreSQL cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters.<br>monitoring | **object**<br><p>Monitoring system.</p> 
clusters.<br>monitoring.<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters.<br>monitoring.<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters.<br>monitoring.<br>link | **string**<br><p>Link to the monitoring system charts for the PostgreSQL cluster.</p> 
clusters.<br>config | **object**<br><p>Configuration of the PostgreSQL cluster.</p> 
clusters.<br>config.<br>version | **string**<br><p>Version of PostgreSQL server software.</p> 
clusters.<br>config.<br>poolerConfig | **object**<br>
clusters.<br>config.<br>poolerConfig.<br>poolingMode | **string**<br><p>Mode that the connection pooler is working in. See descriptions of all modes in the <a href="https://pgbouncer.github.io/usage">documentation for PgBouncer</a>.</p> <ul> <li>SESSION: Session pooling mode.</li> <li>TRANSACTION: Transaction pooling mode.</li> <li>STATEMENT: Statement pooling mode.</li> </ul> 
clusters.<br>config.<br>resources | **object**<br>
clusters.<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/mdb/concepts/instance-types">documentation</a>.</p> 
clusters.<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters.<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
clusters.<br>config.<br>autofailover | **boolean** (boolean)<br><p>Configuration setting which enables/disables autofailover in cluster.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6 | **object** <br>`clusters.config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 9.6 cluster (a combination of settings defined in userConfig and [default_config]).</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
clusters.<br>config.<br>postgresqlConfig_9_6.<br>effectiveConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 9.6 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
clusters.<br>config.<br>postgresqlConfig_9_6.<br>userConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 9.6 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/9.6/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
clusters.<br>config.<br>postgresqlConfig_9_6.<br>defaultConfig.<br>sqlInheritance | **boolean** (boolean)<br><p>This option has been removed in PostgreSQL 10.</p> 
clusters.<br>config.<br>postgresqlConfig_10 | **object** <br>`clusters.config` includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10`<br><br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a PostgreSQL 10 cluster (a combination of settings defined in userConfig and [default_config]).</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>effectiveConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig | **object**<br><p>User-defined settings for a PostgreSQL 10 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>userConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig | **object**<br><p>Default configuration for a PostgreSQL 10 cluster.</p> <p>Options and structure of <code>PostgresqlConfig</code> reflects PostgreSQL configuration file parameters whose detailed description is available in <a href="https://www.postgresql.org/docs/10/static/runtime-config">PostgreSQL documentation</a>.</p> 
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
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterDelay | **integer** (int64)<br><p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMaxpages | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterLruMultiplier | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>bgwriterFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>backendFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>oldSnapshotThreshold | **integer** (int64)<br><p>Acceptable values are -1 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>walLevel | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>synchronousCommit | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointTimeout | **integer** (int64)<br><p>Acceptable values are 30 to 86400, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointCompletionTarget | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>checkpointFlushAfter | **integer** (int64)<br><p>Acceptable values are 0 to 2048, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>minWalSize | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>maxStandbyStreamingDelay | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>defaultStatisticsTarget | **integer** (int64)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>constraintExclusion | **string**<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>cursorTupleFraction | **number** (double)<br>
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>fromCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
clusters.<br>config.<br>postgresqlConfig_10.<br>defaultConfig.<br>joinCollapseLimit | **integer** (int64)<br><p>Acceptable values are 1 to 2147483647, inclusive.</p> 
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
clusters.<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters.<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown ([Host.health] for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well ([Host.health] for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable ([Host.health] for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity ([Host.health] for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters.<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/mdb/api-ref/postgresql/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/mdb/api-ref/postgresql/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/mdb/api-ref/postgresql/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/mdb/api-ref/postgresql/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 