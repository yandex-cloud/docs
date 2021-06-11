---
editable: false
---

# Method update
Modifies the specified MySQL cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MySQL cluster to update. To get the MySQL cluster ID, use a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true,
      "webSql": true
    },

    // `configSpec` includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`
    "mysqlConfig_5_7": {
      "innodbBufferPoolSize": "integer",
      "maxConnections": "integer",
      "longQueryTime": "number",
      "generalLog": true,
      "auditLog": true,
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "integer",
      "defaultAuthenticationPlugin": "string",
      "innodbFlushLogAtTrxCommit": "integer",
      "innodbLockWaitTimeout": "integer",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": true,
      "netReadTimeout": "integer",
      "netWriteTimeout": "integer",
      "groupConcatMaxLen": "integer",
      "tmpTableSize": "integer",
      "maxHeapTableSize": "integer",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": true,
      "innodbNumaInterleave": true,
      "innodbLogBufferSize": "integer",
      "innodbLogFileSize": "integer",
      "innodbIoCapacity": "integer",
      "innodbIoCapacityMax": "integer",
      "innodbReadIoThreads": "integer",
      "innodbWriteIoThreads": "integer",
      "innodbPurgeThreads": "integer",
      "innodbThreadConcurrency": "integer",
      "innodbTempDataFileMaxSize": "integer",
      "threadCacheSize": "integer",
      "threadStack": "integer",
      "joinBufferSize": "integer",
      "sortBufferSize": "integer",
      "tableDefinitionCache": "integer",
      "tableOpenCache": "integer",
      "tableOpenCacheInstances": "integer",
      "explicitDefaultsForTimestamp": true,
      "autoIncrementIncrement": "integer",
      "autoIncrementOffset": "integer",
      "syncBinlog": "integer",
      "binlogCacheSize": "integer",
      "binlogGroupCommitSyncDelay": "integer",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": true,
      "rplSemiSyncMasterWaitForSlaveCount": "integer",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "integer",
      "mdbPreserveBinlogBytes": "integer",
      "interactiveTimeout": "integer",
      "waitTimeout": "integer",
      "mdbOfflineModeEnableLag": "integer",
      "mdbOfflineModeDisableLag": "integer",
      "rangeOptimizerMaxMemSize": "integer"
    },
    "mysqlConfig_8_0": {
      "innodbBufferPoolSize": "integer",
      "maxConnections": "integer",
      "longQueryTime": "number",
      "generalLog": true,
      "auditLog": true,
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "integer",
      "defaultAuthenticationPlugin": "string",
      "innodbFlushLogAtTrxCommit": "integer",
      "innodbLockWaitTimeout": "integer",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": true,
      "netReadTimeout": "integer",
      "netWriteTimeout": "integer",
      "groupConcatMaxLen": "integer",
      "tmpTableSize": "integer",
      "maxHeapTableSize": "integer",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": true,
      "innodbNumaInterleave": true,
      "innodbLogBufferSize": "integer",
      "innodbLogFileSize": "integer",
      "innodbIoCapacity": "integer",
      "innodbIoCapacityMax": "integer",
      "innodbReadIoThreads": "integer",
      "innodbWriteIoThreads": "integer",
      "innodbPurgeThreads": "integer",
      "innodbThreadConcurrency": "integer",
      "innodbTempDataFileMaxSize": "integer",
      "threadCacheSize": "integer",
      "threadStack": "integer",
      "joinBufferSize": "integer",
      "sortBufferSize": "integer",
      "tableDefinitionCache": "integer",
      "tableOpenCache": "integer",
      "tableOpenCacheInstances": "integer",
      "explicitDefaultsForTimestamp": true,
      "autoIncrementIncrement": "integer",
      "autoIncrementOffset": "integer",
      "syncBinlog": "integer",
      "binlogCacheSize": "integer",
      "binlogGroupCommitSyncDelay": "integer",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": true,
      "rplSemiSyncMasterWaitForSlaveCount": "integer",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "integer",
      "regexpTimeLimit": "integer",
      "mdbPreserveBinlogBytes": "integer",
      "interactiveTimeout": "integer",
      "waitTimeout": "integer",
      "mdbOfflineModeEnableLag": "integer",
      "mdbOfflineModeDisableLag": "integer",
      "rangeOptimizerMaxMemSize": "integer"
    },
    // end of the list of possible fields`configSpec`

  },
  "name": "string",
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "securityGroupIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the MySQL cluster should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the MySQL cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the MySQL cluster as ``key:value`` pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-mysql/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-mysql/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of MySQL used in the cluster. Possible values:</p> <ul> <li>5.7</li> <li>8.0</li> </ul> 
configSpec.<br>resources | **object**<br>Resources allocated to MySQL hosts.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mysql/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br>Access policy to DB<br>
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
configSpec.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the Yandex.Cloud management console.</p> <p>See <a href="/docs/managed-mysql/operations/web-sql-query">SQL queries in the management console</a> for more details.</p> 
configSpec.<br>mysqlConfig_5_7 | **object**<br>Configuration for a MySQL 5.7 cluster. <br>`configSpec` includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br><p>Options and structure of ``MysqlConfig5_7`` reflects MySQL 5.7 configuration file</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>For details, see <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin">MySQL documentation for the variable</a></p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
configSpec.<br>mysqlConfig_5_7.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 2, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len">MySQL documentation for the variable</a></p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>collationServer | **string**<br><p>The server default collation.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables Innodb adaptive hash index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single Innodb Redo log file.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity">MySQL documentation for the variable</a></p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">MySQL documentation for the variable</a></p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 16, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 16, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 16, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">MySQL documentation for the variable</a></p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">MySQL documentation for the variable</a></p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>threadCacheSize | **integer** (int64)<br><p>How many threads the server should cache for reuse.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 1000000, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>slaveParallelType | **string**<br><p>When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_5_7.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 107374182400, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
configSpec.<br>mysqlConfig_5_7.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0 | **object**<br>Configuration for a MySQL 8.0 cluster. <br>`configSpec` includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br><p>Options and structure of ``MysqlConfig8_0`` reflects MySQL 8.0 configuration file</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
configSpec.<br>mysqlConfig_8_0.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>generalLog | **boolean** (boolean)<br><p>Enable writing of general query log of MySQL.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>auditLog | **boolean** (boolean)<br><p>Enable writing of audit log of MySQL.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>sqlMode[] | **string**<br><p>Server SQL mode of MySQL.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>maxAllowedPacket | **integer** (int64)<br><p>The maximum size in bytes of one packet.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1024 to 1073741824, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>defaultAuthenticationPlugin | **string**<br><p>Authentication plugin used in the managed MySQL cluster.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin">MySQL documentation for the variable</a></p> <ul> <li>MYSQL_NATIVE_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Using <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
configSpec.<br>mysqlConfig_8_0.<br>innodbFlushLogAtTrxCommit | **integer** (int64)<br><p>Transaction log flush behaviour.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 2, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbLockWaitTimeout | **integer** (int64)<br><p>Max time in seconds for a transaction to wait for a row lock</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 28800, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>transactionIsolation | **string**<br><p>Default transaction isolation level.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbPrintAllDeadlocks | **boolean** (boolean)<br><p>Print information about deadlocks in error log</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>netReadTimeout | **integer** (int64)<br><p>The number of seconds to wait for more data from a connection before aborting the read.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>netWriteTimeout | **integer** (int64)<br><p>The number of seconds to wait for a block to be written to a connection before aborting the write.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 1200, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>groupConcatMaxLen | **integer** (int64)<br><p>The maximum permitted result length in bytes for the GROUP_CONCAT() function.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len">MySQL documentation for the variable</a></p> <p>Acceptable values are 4 to 33554432, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tmpTableSize | **integer** (int64)<br><p>The maximum size of internal in-memory temporary tables.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 1024 to 536870912, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>maxHeapTableSize | **integer** (int64)<br><p>This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 16384 to 536870912, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>defaultTimeZone | **string**<br><p>The servers default time zone.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>characterSetServer | **string**<br><p>The servers default character set.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>collationServer | **string**<br><p>The server default collation.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbAdaptiveHashIndex | **boolean** (boolean)<br><p>Enables Innodb adaptive hash index</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbNumaInterleave | **boolean** (boolean)<br><p>Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave">MySQL documentation for the variable</a></p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbLogBufferSize | **integer** (int64)<br><p>The size in bytes of the buffer that InnoDB uses to write to the log files on disk.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbLogFileSize | **integer** (int64)<br><p>The size in bytes of the single Innodb Redo log file.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size">MySQL documentation for the variable</a></p> <p>Acceptable values are 268435456 to 4294967296, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbIoCapacity | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity">MySQL documentation for the variable</a></p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbIoCapacityMax | **integer** (int64)<br><p>Limits IO available for InnoDB background tasks</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max">MySQL documentation for the variable</a></p> <p>Acceptable values are 100 to 100000, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbReadIoThreads | **integer** (int64)<br><p>The number of I/O threads for read operations in InnoDB.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 16, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbWriteIoThreads | **integer** (int64)<br><p>The number of I/O threads for write operations in InnoDB.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 16, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbPurgeThreads | **integer** (int64)<br><p>The number of background threads devoted to the InnoDB purge operation.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads">MySQL documentation for the variable</a></p> <p>Acceptable values are 1 to 16, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbThreadConcurrency | **integer** (int64)<br><p>Defines the maximum number of threads permitted inside of InnoDB.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency">MySQL documentation for the variable</a></p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>innodbTempDataFileMaxSize | **integer** (int64)<br><p>Limits the max size of InnoDB temp tablespace</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path">MySQL documentation for the variable</a></p> <p>Acceptable values are 0 to 107374182400, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>threadCacheSize | **integer** (int64)<br><p>How many threads the server should cache for reuse.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>threadStack | **integer** (int64)<br><p>The stack size for each thread. The default is large enough for normal operation.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 131072 to 16777216, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>joinBufferSize | **integer** (int64)<br><p>The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>sortBufferSize | **integer** (int64)<br><p>Each session that must perform a sort allocates a buffer of this size.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1024 to 16777216, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tableDefinitionCache | **integer** (int64)<br><p>The number of table definitions that can be stored in the definition cache.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tableOpenCache | **integer** (int64)<br><p>The number of open tables for all threads.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 400 to 524288, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>tableOpenCacheInstances | **integer** (int64)<br><p>The number of open tables cache instances.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 32, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>explicitDefaultsForTimestamp | **boolean** (boolean)<br><p>This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>autoIncrementIncrement | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_increment">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>autoIncrementOffset | **integer** (int64)<br><p>Can be used to control the operation of AUTO_INCREMENT columns.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_auto_increment_offset">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>syncBinlog | **integer** (int64)<br><p>Controls how often the MySQL server synchronizes the binary log to disk.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 4096, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogCacheSize | **integer** (int64)<br><p>The size of the cache to hold changes to the binary log during a transaction.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 4096 to 67108864, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogGroupCommitSyncDelay | **integer** (int64)<br><p>Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 1000000, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogRowImage | **string**<br><p>For MySQL row-based replication, this variable determines how row images are written to the binary log.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>binlogRowsQueryLogEvents | **boolean** (boolean)<br><p>When enabled, it causes the server to write informational log events such as row query log events into its binary log.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>rplSemiSyncMasterWaitForSlaveCount | **integer** (int64)<br><p>The number of replica acknowledgments the source must receive per transaction before proceeding.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1 to 2, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>slaveParallelType | **string**<br><p>When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type">MySQL documentation for the variable</a>.</p> 
configSpec.<br>mysqlConfig_8_0.<br>slaveParallelWorkers | **integer** (int64)<br><p>Sets the number of applier threads for executing replication transactions in parallel.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 64, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>regexpTimeLimit | **integer** (int64)<br><p>The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 0 to 1048576, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>mdbPreserveBinlogBytes | **integer** (int64)<br><p>The size of the binary log to hold.</p> <p>Acceptable values are 1073741824 to 107374182400, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>interactiveTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on an interactive connection before closing it.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>waitTimeout | **integer** (int64)<br><p>The number of seconds the server waits for activity on a noninteractive connection before closing it.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 600 to 86400, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>mdbOfflineModeEnableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.</p> <p>Acceptable values are 600 to 432000, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>mdbOfflineModeDisableLag | **integer** (int64)<br><p>Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.</p> <p>Acceptable values are 60 to 86400, inclusive.</p> 
configSpec.<br>mysqlConfig_8_0.<br>rangeOptimizerMaxMemSize | **integer** (int64)<br><p>The limit on memory consumption for the range optimizer.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 1048576 to 268435456, inclusive.</p> 
name | **string**<br><p>New name for the cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
maintenanceWindow | **object**<br><p>New maintenance window settings for the cluster.</p> <p>A maintenance window settings.</p> 
maintenanceWindow.<br>anytime | **object**<br>Maintenance operation can be scheduled anytime. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Maintenance operation can be scheduled on a weekly basis. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br><p>Weelky maintenance window settings.</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week (in ``DDD`` format).</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC (in ``HH`` format).</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 