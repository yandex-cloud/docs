---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mysql/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the cluster in.
            To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the cluster. The name must be unique within the folder.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the cluster as `key:value` pairs.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        environment:
          description: |-
            **enum** (Environment)
            Deployment environment of the MySQL cluster.
            - `ENVIRONMENT_UNSPECIFIED`
            - `PRODUCTION`: Environment for stable versions of your apps.
            A conservative update policy is in effect: only bug fixes are applied during regular maintenance.
            - `PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself.
            This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment.
            However, not every update ensures backward compatibility.
          type: string
          enum:
            - ENVIRONMENT_UNSPECIFIED
            - PRODUCTION
            - PRESTABLE
        configSpec:
          description: |-
            **[ConfigSpec](#yandex.cloud.mdb.mysql.v1.ConfigSpec)**
            Configuration of the cluster.
          $ref: '#/definitions/ConfigSpec'
        databaseSpecs:
          description: |-
            **[DatabaseSpec](#yandex.cloud.mdb.mysql.v1.DatabaseSpec)**
            Configuration of databases in the cluster.
          type: array
          items:
            $ref: '#/definitions/DatabaseSpec'
        userSpecs:
          description: |-
            **[UserSpec](#yandex.cloud.mdb.mysql.v1.UserSpec)**
            Configuration of database users in the cluster.
          type: array
          items:
            $ref: '#/definitions/UserSpec'
        hostSpecs:
          description: |-
            **[HostSpec](#yandex.cloud.mdb.mysql.v1.HostSpec)**
            Configuration of hosts in the cluster.
          type: array
          items:
            $ref: '#/definitions/HostSpec'
        networkId:
          description: |-
            **string**
            ID of the network to create the cluster in.
          type: string
        securityGroupIds:
          description: |-
            **string**
            List of security group IDs to apply to the cluster.
          type: array
          items:
            type: string
        deletionProtection:
          description: |-
            **boolean**
            This option prevents unintended deletion of the cluster.
          type: boolean
        hostGroupIds:
          description: |-
            **string**
            Host groups hosting VMs of the cluster.
          type: array
          items:
            type: string
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.mdb.mysql.v1.MaintenanceWindow)**
            Window of maintenance operations.
          $ref: '#/definitions/MaintenanceWindow'
        diskEncryptionKeyId:
          description: |-
            **string**
            ID of the key to encrypt cluster disks.
          type: string
      required:
        - folderId
        - name
      additionalProperties: false
    definitions:
      MysqlConfig5_7:
        type: object
        properties:
          innodbBufferPoolSize:
            description: |-
              **string** (int64)
              Size of the InnoDB buffer pool used for caching table and index data.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details.
            type: string
            format: int64
          maxConnections:
            description: |-
              **string** (int64)
              The maximum permitted number of simultaneous client connections.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections) for details.
            type: string
            format: int64
          longQueryTime:
            description: |-
              **number** (double)
              Time that it takes to process a query before it is considered slow.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time) for details.
            type: number
            format: double
          generalLog:
            description: |-
              **boolean**
              Enable writing of general query log of MySQL.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log) for details.
            type: boolean
          auditLog:
            description: |-
              **boolean**
              Enable writing of audit log of MySQL.
              See [MySQL documentation](https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/audit-log-reference.html#audit-log-options-variables) for details.
            type: boolean
          sqlMode:
            description: |-
              **enum** (SQLMode)
              Server SQL mode of MySQL.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting) for details.
              - `SQLMODE_UNSPECIFIED`
              - `ALLOW_INVALID_DATES`
              - `ANSI_QUOTES`
              - `ERROR_FOR_DIVISION_BY_ZERO`
              - `HIGH_NOT_PRECEDENCE`
              - `IGNORE_SPACE`
              - `NO_AUTO_VALUE_ON_ZERO`
              - `NO_BACKSLASH_ESCAPES`
              - `NO_ENGINE_SUBSTITUTION`
              - `NO_UNSIGNED_SUBTRACTION`
              - `NO_ZERO_DATE`
              - `NO_ZERO_IN_DATE`
              - `NO_FIELD_OPTIONS`
              - `NO_KEY_OPTIONS`
              - `NO_TABLE_OPTIONS`
              - `ONLY_FULL_GROUP_BY`
              - `PAD_CHAR_TO_FULL_LENGTH`
              - `PIPES_AS_CONCAT`
              - `REAL_AS_FLOAT`
              - `STRICT_ALL_TABLES`
              - `STRICT_TRANS_TABLES`
              - `ANSI`
              - `TRADITIONAL`
              - `DB2`
              - `MAXDB`
              - `MSSQL`
              - `MYSQL323`
              - `MYSQL40`
              - `ORACLE`
              - `POSTGRESQL`
              - `NO_AUTO_CREATE_USER`
              - `NO_DIR_IN_CREATE`
            type: array
            items:
              type: string
              enum:
                - SQLMODE_UNSPECIFIED
                - ALLOW_INVALID_DATES
                - ANSI_QUOTES
                - ERROR_FOR_DIVISION_BY_ZERO
                - HIGH_NOT_PRECEDENCE
                - IGNORE_SPACE
                - NO_AUTO_VALUE_ON_ZERO
                - NO_BACKSLASH_ESCAPES
                - NO_ENGINE_SUBSTITUTION
                - NO_UNSIGNED_SUBTRACTION
                - NO_ZERO_DATE
                - NO_ZERO_IN_DATE
                - NO_FIELD_OPTIONS
                - NO_KEY_OPTIONS
                - NO_TABLE_OPTIONS
                - ONLY_FULL_GROUP_BY
                - PAD_CHAR_TO_FULL_LENGTH
                - PIPES_AS_CONCAT
                - REAL_AS_FLOAT
                - STRICT_ALL_TABLES
                - STRICT_TRANS_TABLES
                - ANSI
                - TRADITIONAL
                - DB2
                - MAXDB
                - MSSQL
                - MYSQL323
                - MYSQL40
                - ORACLE
                - POSTGRESQL
                - NO_AUTO_CREATE_USER
                - NO_DIR_IN_CREATE
          maxAllowedPacket:
            description: |-
              **string** (int64)
              The maximum size in bytes of one packet.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet) for details.
            type: string
            format: int64
          defaultAuthenticationPlugin:
            description: |-
              **enum** (AuthPlugin)
              Authentication plugin used in the managed MySQL cluster.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.
              - `AUTH_PLUGIN_UNSPECIFIED`
              - `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
              - `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
              - `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
              - `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
              - `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/).
            type: string
            enum:
              - AUTH_PLUGIN_UNSPECIFIED
              - MYSQL_NATIVE_PASSWORD
              - CACHING_SHA2_PASSWORD
              - SHA256_PASSWORD
              - MYSQL_NO_LOGIN
              - MDB_IAMPROXY_AUTH
          innodbFlushLogAtTrxCommit:
            description: |-
              **string** (int64)
              Transaction log flush behaviour.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details.
            type: string
            format: int64
          innodbLockWaitTimeout:
            description: |-
              **string** (int64)
              Max time in seconds for a transaction to wait for a row lock.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details.
            type: string
            format: int64
          transactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Default transaction isolation level.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation) for details.
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `READ_COMMITTED`
              - `REPEATABLE_READ`
              - `SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - READ_COMMITTED
              - REPEATABLE_READ
              - SERIALIZABLE
          innodbPrintAllDeadlocks:
            description: |-
              **boolean**
              Print information about deadlocks in error log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details.
            type: boolean
          netReadTimeout:
            description: |-
              **string** (int64)
              The number of seconds to wait for more data from a connection before aborting the read.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout) for details.
            type: string
            format: int64
          netWriteTimeout:
            description: |-
              **string** (int64)
              The number of seconds to wait for a block to be written to a connection before aborting the write.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout) for details.
            type: string
            format: int64
          groupConcatMaxLen:
            description: |-
              **string** (int64)
              The maximum permitted result length in bytes for the GROUP_CONCAT() function.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len) for details.
            type: string
            format: int64
          tmpTableSize:
            description: |-
              **string** (int64)
              The maximum size of internal in-memory temporary tables.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size) for details.
            type: string
            format: int64
          maxHeapTableSize:
            description: |-
              **string** (int64)
              This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size) for details.
            type: string
            format: int64
          defaultTimeZone:
            description: |-
              **string**
              The servers default time zone.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone) for details.
            default: time-zone) for details
            type: string
          characterSetServer:
            description: |-
              **string**
              The servers default character set.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server) for details.
            type: string
          collationServer:
            description: |-
              **string**
              The server default collation.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server) for details.
            type: string
          innodbAdaptiveHashIndex:
            description: |-
              **boolean**
              Enables InnoDB adaptive hash index.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details.
            type: boolean
          innodbNumaInterleave:
            description: |-
              **boolean**
              Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details.
            type: boolean
          innodbLogBufferSize:
            description: |-
              **string** (int64)
              The size in bytes of the buffer that InnoDB uses to write to the log files on disk.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details.
            type: string
            format: int64
          innodbLogFileSize:
            description: |-
              **string** (int64)
              The size in bytes of the single InnoDB Redo log file.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details.
            type: string
            format: int64
          innodbIoCapacity:
            description: |-
              **string** (int64)
              Limits IO available for InnoDB background tasks.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details.
            type: string
            format: int64
          innodbIoCapacityMax:
            description: |-
              **string** (int64)
              Limits IO available for InnoDB background tasks.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details.
            type: string
            format: int64
          innodbReadIoThreads:
            description: |-
              **string** (int64)
              The number of I/O threads for read operations in InnoDB.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details.
            type: string
            format: int64
          innodbWriteIoThreads:
            description: |-
              **string** (int64)
              The number of I/O threads for write operations in InnoDB.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details.
            type: string
            format: int64
          innodbPurgeThreads:
            description: |-
              **string** (int64)
              The number of background threads devoted to the InnoDB purge operation.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details.
            type: string
            format: int64
          innodbThreadConcurrency:
            description: |-
              **string** (int64)
              Defines the maximum number of threads permitted inside of InnoDB.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details.
            type: string
            format: int64
          innodbTempDataFileMaxSize:
            description: |-
              **string** (int64)
              Limits the max size of InnoDB temp tablespace.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details.
            type: string
            format: int64
          threadCacheSize:
            description: |-
              **string** (int64)
              A number of threads the server should cache for reuse.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size) for details.
            type: string
            format: int64
          threadStack:
            description: |-
              **string** (int64)
              The stack size for each thread. The default is large enough for normal operation.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack) for details.
            type: string
            format: int64
          joinBufferSize:
            description: |-
              **string** (int64)
              The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size) for details.
            type: string
            format: int64
          sortBufferSize:
            description: |-
              **string** (int64)
              Each session that must perform a sort allocates a buffer of this size.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size) for details.
            type: string
            format: int64
          tableDefinitionCache:
            description: |-
              **string** (int64)
              The number of table definitions that can be stored in the definition cache.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache) for details.
            type: string
            format: int64
          tableOpenCache:
            description: |-
              **string** (int64)
              The number of open tables for all threads.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache) for details.
            type: string
            format: int64
          tableOpenCacheInstances:
            description: |-
              **string** (int64)
              The number of open tables cache instances.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances) for details.
            type: string
            format: int64
          explicitDefaultsForTimestamp:
            description: |-
              **boolean**
              Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details.
            type: boolean
          autoIncrementIncrement:
            description: |-
              **string** (int64)
              Can be used to control the operation of AUTO_INCREMENT columns.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_increment) for details.
            type: string
            format: int64
          autoIncrementOffset:
            description: |-
              **string** (int64)
              Can be used to control the operation of AUTO_INCREMENT columns.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_offset) for details.
            type: string
            format: int64
          syncBinlog:
            description: |-
              **string** (int64)
              Controls how often the MySQL server synchronizes the binary log to disk.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog) for details.
            type: string
            format: int64
          binlogCacheSize:
            description: |-
              **string** (int64)
              The size of the cache to hold changes to the binary log during a transaction.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details.
            type: string
            format: int64
          binlogGroupCommitSyncDelay:
            description: |-
              **string** (int64)
              Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.
              See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details.
            type: string
            format: int64
          binlogRowImage:
            description: |-
              **enum** (BinlogRowImage)
              For MySQL row-based replication, this variable determines how row images are written to the binary log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.
              - `BINLOG_ROW_IMAGE_UNSPECIFIED`
              - `FULL`
              - `MINIMAL`
              - `NOBLOB`
            type: string
            enum:
              - BINLOG_ROW_IMAGE_UNSPECIFIED
              - FULL
              - MINIMAL
              - NOBLOB
          binlogRowsQueryLogEvents:
            description: |-
              **boolean**
              When enabled, it causes the server to write informational log events such as row query log events into its binary log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details.
            type: boolean
          rplSemiSyncMasterWaitForSlaveCount:
            description: |-
              **string** (int64)
              The number of replica acknowledgments the source must receive per transaction before proceeding.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details.
            type: string
            format: int64
          slaveParallelType:
            description: |-
              **enum** (SlaveParallelType)
              When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.
              - `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
              - `DATABASE`
              - `LOGICAL_CLOCK`
            type: string
            enum:
              - SLAVE_PARALLEL_TYPE_UNSPECIFIED
              - DATABASE
              - LOGICAL_CLOCK
          slaveParallelWorkers:
            description: |-
              **string** (int64)
              Sets the number of applier threads for executing replication transactions in parallel.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details.
            type: string
            format: int64
          mdbPreserveBinlogBytes:
            description: |-
              **string** (int64)
              The size of the binary log to hold.
            type: string
            format: int64
          interactiveTimeout:
            description: |-
              **string** (int64)
              The number of seconds the server waits for activity on an interactive connection before closing it.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout) for details.
            type: string
            format: int64
          waitTimeout:
            description: |-
              **string** (int64)
              The number of seconds the server waits for activity on a noninteractive connection before closing it.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout) for details.
            type: string
            format: int64
          mdbOfflineModeEnableLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
            type: string
            format: int64
          mdbOfflineModeDisableLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
              Should be less than mdb_offline_mode_enable_lag value.
            type: string
            format: int64
          rangeOptimizerMaxMemSize:
            description: |-
              **string** (int64)
              The limit on memory consumption for the range optimizer.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details.
            type: string
            format: int64
          slowQueryLog:
            description: |-
              **boolean**
              Manages slow query log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details.
            type: boolean
          slowQueryLogAlwaysWriteTime:
            description: |-
              **number** (double)
              Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details.
            type: number
            format: double
          logSlowRateType:
            description: |-
              **enum** (LogSlowRateType)
              Specifies slow log granularity for `log_slow_rate_limit` values QUERY or SESSION.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.
              - `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
              - `SESSION`
              - `QUERY`
            type: string
            enum:
              - LOG_SLOW_RATE_TYPE_UNSPECIFIED
              - SESSION
              - QUERY
          logSlowRateLimit:
            description: |-
              **string** (int64)
              Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details.
            type: string
            format: int64
          logSlowSpStatements:
            description: |-
              **boolean**
              When TRUE, statements executed by stored procedures are logged to the slow log.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details.
            type: boolean
          logSlowFilter:
            description: |-
              **enum** (LogSlowFilterType)
              Filters the slow log by the query's execution plan.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.
              - `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
              - `FULL_SCAN`
              - `FULL_JOIN`
              - `TMP_TABLE`
              - `TMP_TABLE_ON_DISK`
              - `FILESORT`
              - `FILESORT_ON_DISK`
            type: array
            items:
              type: string
              enum:
                - LOG_SLOW_FILTER_TYPE_UNSPECIFIED
                - FULL_SCAN
                - FULL_JOIN
                - TMP_TABLE
                - TMP_TABLE_ON_DISK
                - FILESORT
                - FILESORT_ON_DISK
          mdbPriorityChoiceMaxLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
              Should be less than mdb_offline_mode_disable_lag.
            type: string
            format: int64
          innodbPageSize:
            description: |-
              **string** (int64)
              Specifies the page size for InnoDB tablespaces.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size).
            type: string
            format: int64
          innodbOnlineAlterLogMaxSize:
            description: |-
              **string** (int64)
              The limit in bytes on the size of the temporary log files used during online DDL operations
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size).
            type: string
            format: int64
          innodbFtMinTokenSize:
            description: |-
              **string** (int64)
              Minimum length of words that are stored in an InnoDB FULLTEXT index
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size).
            type: string
            format: int64
          innodbFtMaxTokenSize:
            description: |-
              **string** (int64)
              Maximum length of words that are stored in an InnoDB FULLTEXT index
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size).
            type: string
            format: int64
          lowerCaseTableNames:
            description: |-
              **string** (int64)
              Table names storage and comparison strategy
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names).
            type: string
            format: int64
          showCompatibility_56:
            description: |-
              **boolean**
              Manages MySQL 5.6 compatibility
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56).
            type: boolean
          maxSpRecursionDepth:
            description: |-
              **string** (int64)
              The number of times that any given stored procedure may be called recursively.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth).
            type: string
            format: int64
          innodbCompressionLevel:
            description: |-
              **string** (int64)
              The level of zlib compression to use for InnoDB compressed tables and indexes.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level).
            type: string
            format: int64
          binlogTransactionDependencyTracking:
            description: |-
              **enum** (BinlogTransactionDependencyTracking)
              Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).
              - `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
              - `COMMIT_ORDER`
              - `WRITESET`
              - `WRITESET_SESSION`
            type: string
            enum:
              - BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED
              - COMMIT_ORDER
              - WRITESET
              - WRITESET_SESSION
          autocommit:
            description: |-
              **boolean**
              Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_autocommit).
            type: boolean
          innodbStatusOutput:
            description: |-
              **boolean**
              Enables or disables periodic output for the standard InnoDB Monitor.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output).
            type: boolean
          innodbStrictMode:
            description: |-
              **boolean**
              When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_strict_mode).
            type: boolean
          innodbPrintLockWaitTimeoutInfo:
            description: |-
              **boolean**
              Makes InnoDB to write information about all lock wait timeout errors into the log file.
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info).
            type: boolean
          logErrorVerbosity:
            description: |-
              **string** (int64)
              System variable specifies the verbosity for handling events intended for the error log
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_error_verbosity).
            type: string
            format: int64
          maxDigestLength:
            description: |-
              **string** (int64)
              The maximum number of bytes of memory reserved per session for computation of normalized statement digests.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_digest_length).
            type: string
            format: int64
          queryCacheLimit:
            description: |-
              **string** (int64)
              Do not cache results that are larger than this number of bytes.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_limit).
            type: string
            format: int64
          queryCacheSize:
            description: |-
              **string** (int64)
              The amount of memory allocated for caching query results.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_size).
            type: string
            format: int64
          queryCacheType:
            description: |-
              **string** (int64)
              Set the query cache type.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_type).
            type: string
            format: int64
          lockWaitTimeout:
            description: |-
              **string** (int64)
              This variable specifies the timeout in seconds for attempts to acquire metadata locks
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lock_wait_timeout).
            type: string
            format: int64
          maxPreparedStmtCount:
            description: |-
              **string** (int64)
              This variable limits the total number of prepared statements in the server.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_prepared_stmt_count).
            type: string
            format: int64
          optimizerSwitch:
            description: |-
              **string**
              The system variable enables control over optimizer behavior.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch)
              https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html
            type: string
          optimizerSearchDepth:
            description: |-
              **string** (int64)
              The maximum depth of search performed by the query optimizer
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html)
            type: string
            format: int64
          queryResponseTimeStats:
            description: |-
              **boolean**
              Enables and disables collection of query times
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html#query_response_time_stats).
            type: boolean
          userstat:
            description: |-
              **boolean**
              Enables or disables collection of statistics
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/user_stats.html#userstat).
            type: boolean
          maxExecutionTime:
            description: |-
              **string** (int64)
              The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_execution_time)
            type: string
            format: int64
          auditLogPolicy:
            description: |-
              **enum** (AuditLogPolicy)
              The policy controlling how the audit log plugin writes events to its log file
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/audit-log-reference.html#sysvar_audit_log_policy)
              - `AUDIT_LOG_POLICY_UNSPECIFIED`
              - `ALL`
              - `LOGINS`
              - `QUERIES`
              - `NONE`
            type: string
            enum:
              - AUDIT_LOG_POLICY_UNSPECIFIED
              - ALL
              - LOGINS
              - QUERIES
              - NONE
          innodbLruScanDepth:
            description: |-
              **string** (int64)
              A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth)
            type: string
            format: int64
          mdbForceSsl:
            description: |-
              **boolean**
              Force ssl on all hosts (require_secure_transport)
            type: boolean
          innodbChangeBuffering:
            description: |-
              **enum** (InnodbChangeBuffering)
              An optimization for change buffering
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_change_buffering).
              - `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
              - `INNODB_CHANGE_BUFFERING_NONE`
              - `INNODB_CHANGE_BUFFERING_INSERTS`
              - `INNODB_CHANGE_BUFFERING_DELETES`
              - `INNODB_CHANGE_BUFFERING_CHANGES`
              - `INNODB_CHANGE_BUFFERING_PURGES`
              - `INNODB_CHANGE_BUFFERING_ALL`
            type: string
            enum:
              - INNODB_CHANGE_BUFFERING_UNSPECIFIED
              - INNODB_CHANGE_BUFFERING_NONE
              - INNODB_CHANGE_BUFFERING_INSERTS
              - INNODB_CHANGE_BUFFERING_DELETES
              - INNODB_CHANGE_BUFFERING_CHANGES
              - INNODB_CHANGE_BUFFERING_PURGES
              - INNODB_CHANGE_BUFFERING_ALL
          maxWriteLockCount:
            description: |-
              **string** (int64)
              Permit some pending read lock requests interval
              P.S. Should be UInt64, but java fails to handle UInt64 limits
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_write_lock_count).
            type: string
            format: int64
      MysqlConfig8_0:
        type: object
        properties:
          innodbBufferPoolSize:
            description: |-
              **string** (int64)
              Size of the InnoDB buffer pool used for caching table and index data.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details.
            type: string
            format: int64
          maxConnections:
            description: |-
              **string** (int64)
              The maximum permitted number of simultaneous client connections.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections) for details.
            type: string
            format: int64
          longQueryTime:
            description: |-
              **number** (double)
              Time that it takes to process a query before it is considered slow.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time) for details.
            type: number
            format: double
          generalLog:
            description: |-
              **boolean**
              Enable writing of general query log of MySQL.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log) for details.
            type: boolean
          auditLog:
            description: |-
              **boolean**
              Enable writing of audit log of MySQL.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables) for details.
            type: boolean
          sqlMode:
            description: |-
              **enum** (SQLMode)
              Server SQL mode of MySQL.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) for details.
              - `SQLMODE_UNSPECIFIED`
              - `ALLOW_INVALID_DATES`
              - `ANSI_QUOTES`
              - `ERROR_FOR_DIVISION_BY_ZERO`
              - `HIGH_NOT_PRECEDENCE`
              - `IGNORE_SPACE`
              - `NO_AUTO_VALUE_ON_ZERO`
              - `NO_BACKSLASH_ESCAPES`
              - `NO_ENGINE_SUBSTITUTION`
              - `NO_UNSIGNED_SUBTRACTION`
              - `NO_ZERO_DATE`
              - `NO_ZERO_IN_DATE`
              - `NO_FIELD_OPTIONS`
              - `NO_KEY_OPTIONS`
              - `NO_TABLE_OPTIONS`
              - `ONLY_FULL_GROUP_BY`
              - `PAD_CHAR_TO_FULL_LENGTH`
              - `PIPES_AS_CONCAT`
              - `REAL_AS_FLOAT`
              - `STRICT_ALL_TABLES`
              - `STRICT_TRANS_TABLES`
              - `ANSI`
              - `TRADITIONAL`
              - `DB2`
              - `MAXDB`
              - `MSSQL`
              - `MYSQL323`
              - `MYSQL40`
              - `ORACLE`
              - `POSTGRESQL`
              - `NO_AUTO_CREATE_USER`
              - `NO_DIR_IN_CREATE`
            type: array
            items:
              type: string
              enum:
                - SQLMODE_UNSPECIFIED
                - ALLOW_INVALID_DATES
                - ANSI_QUOTES
                - ERROR_FOR_DIVISION_BY_ZERO
                - HIGH_NOT_PRECEDENCE
                - IGNORE_SPACE
                - NO_AUTO_VALUE_ON_ZERO
                - NO_BACKSLASH_ESCAPES
                - NO_ENGINE_SUBSTITUTION
                - NO_UNSIGNED_SUBTRACTION
                - NO_ZERO_DATE
                - NO_ZERO_IN_DATE
                - NO_FIELD_OPTIONS
                - NO_KEY_OPTIONS
                - NO_TABLE_OPTIONS
                - ONLY_FULL_GROUP_BY
                - PAD_CHAR_TO_FULL_LENGTH
                - PIPES_AS_CONCAT
                - REAL_AS_FLOAT
                - STRICT_ALL_TABLES
                - STRICT_TRANS_TABLES
                - ANSI
                - TRADITIONAL
                - DB2
                - MAXDB
                - MSSQL
                - MYSQL323
                - MYSQL40
                - ORACLE
                - POSTGRESQL
                - NO_AUTO_CREATE_USER
                - NO_DIR_IN_CREATE
          maxAllowedPacket:
            description: |-
              **string** (int64)
              The maximum size in bytes of one packet.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) for details.
            type: string
            format: int64
          defaultAuthenticationPlugin:
            description: |-
              **enum** (AuthPlugin)
              Authentication plugin used in the managed MySQL cluster.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.
              - `AUTH_PLUGIN_UNSPECIFIED`
              - `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
              - `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
              - `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
              - `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
              - `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/).
            type: string
            enum:
              - AUTH_PLUGIN_UNSPECIFIED
              - MYSQL_NATIVE_PASSWORD
              - CACHING_SHA2_PASSWORD
              - SHA256_PASSWORD
              - MYSQL_NO_LOGIN
              - MDB_IAMPROXY_AUTH
          innodbFlushLogAtTrxCommit:
            description: |-
              **string** (int64)
              Transaction log flush behaviour.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details.
            type: string
            format: int64
          innodbLockWaitTimeout:
            description: |-
              **string** (int64)
              Max time in seconds for a transaction to wait for a row lock.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details.
            type: string
            format: int64
          transactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Default transaction isolation level.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation) for details.
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `READ_COMMITTED`
              - `REPEATABLE_READ`
              - `SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - READ_COMMITTED
              - REPEATABLE_READ
              - SERIALIZABLE
          innodbPrintAllDeadlocks:
            description: |-
              **boolean**
              Print information about deadlocks in error log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details.
            type: boolean
          netReadTimeout:
            description: |-
              **string** (int64)
              The number of seconds to wait for more data from a connection before aborting the read.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout) for details.
            type: string
            format: int64
          netWriteTimeout:
            description: |-
              **string** (int64)
              The number of seconds to wait for a block to be written to a connection before aborting the write.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout) for details.
            type: string
            format: int64
          groupConcatMaxLen:
            description: |-
              **string** (int64)
              The maximum permitted result length in bytes for the GROUP_CONCAT() function.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len) for details.
            type: string
            format: int64
          tmpTableSize:
            description: |-
              **string** (int64)
              The maximum size of internal in-memory temporary tables.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size) for details.
            type: string
            format: int64
          maxHeapTableSize:
            description: |-
              **string** (int64)
              This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size) for details.
            type: string
            format: int64
          defaultTimeZone:
            description: |-
              **string**
              The servers default time zone.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone) for details.
            default: time-zone) for details
            type: string
          characterSetServer:
            description: |-
              **string**
              The servers default character set.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server) for details.
            type: string
          collationServer:
            description: |-
              **string**
              The server default collation.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server) for details.
            type: string
          innodbAdaptiveHashIndex:
            description: |-
              **boolean**
              Enables InnoDB adaptive hash index.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details.
            type: boolean
          innodbNumaInterleave:
            description: |-
              **boolean**
              Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details.
            type: boolean
          innodbLogBufferSize:
            description: |-
              **string** (int64)
              The size in bytes of the buffer that InnoDB uses to write to the log files on disk.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details.
            type: string
            format: int64
          innodbLogFileSize:
            description: |-
              **string** (int64)
              The size in bytes of the single InnoDB Redo log file.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details.
            type: string
            format: int64
          innodbIoCapacity:
            description: |-
              **string** (int64)
              Limits IO available for InnoDB background tasks.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details.
            type: string
            format: int64
          innodbIoCapacityMax:
            description: |-
              **string** (int64)
              Limits IO available for InnoDB background tasks.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details.
            type: string
            format: int64
          innodbReadIoThreads:
            description: |-
              **string** (int64)
              The number of I/O threads for read operations in InnoDB.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details.
            type: string
            format: int64
          innodbWriteIoThreads:
            description: |-
              **string** (int64)
              The number of I/O threads for write operations in InnoDB.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details.
            type: string
            format: int64
          innodbPurgeThreads:
            description: |-
              **string** (int64)
              The number of background threads devoted to the InnoDB purge operation.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details.
            type: string
            format: int64
          innodbThreadConcurrency:
            description: |-
              **string** (int64)
              Defines the maximum number of threads permitted inside of InnoDB.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details.
            type: string
            format: int64
          innodbTempDataFileMaxSize:
            description: |-
              **string** (int64)
              Limits the max size of InnoDB temp tablespace.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details.
            type: string
            format: int64
          threadCacheSize:
            description: |-
              **string** (int64)
              How many threads the server should cache for reuse.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size) for details.
            type: string
            format: int64
          threadStack:
            description: |-
              **string** (int64)
              The stack size for each thread. The default is large enough for normal operation.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack) for details.
            type: string
            format: int64
          joinBufferSize:
            description: |-
              **string** (int64)
              The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size) for details.
            type: string
            format: int64
          sortBufferSize:
            description: |-
              **string** (int64)
              Each session that must perform a sort allocates a buffer of this size.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size) for details.
            type: string
            format: int64
          tableDefinitionCache:
            description: |-
              **string** (int64)
              The number of table definitions that can be stored in the definition cache.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache) for details.
            type: string
            format: int64
          tableOpenCache:
            description: |-
              **string** (int64)
              The number of open tables for all threads.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache) for details.
            type: string
            format: int64
          tableOpenCacheInstances:
            description: |-
              **string** (int64)
              The number of open tables cache instances.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances) for details.
            type: string
            format: int64
          explicitDefaultsForTimestamp:
            description: |-
              **boolean**
              Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details.
            type: boolean
          autoIncrementIncrement:
            description: |-
              **string** (int64)
              Can be used to control the operation of AUTO_INCREMENT columns.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment) for details.
            type: string
            format: int64
          autoIncrementOffset:
            description: |-
              **string** (int64)
              Can be used to control the operation of AUTO_INCREMENT columns.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset) for details.
            type: string
            format: int64
          syncBinlog:
            description: |-
              **string** (int64)
              Controls how often the MySQL server synchronizes the binary log to disk.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog) for details.
            type: string
            format: int64
          binlogCacheSize:
            description: |-
              **string** (int64)
              The size of the cache to hold changes to the binary log during a transaction.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details.
            type: string
            format: int64
          binlogGroupCommitSyncDelay:
            description: |-
              **string** (int64)
              Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details.
            type: string
            format: int64
          binlogRowImage:
            description: |-
              **enum** (BinlogRowImage)
              For MySQL row-based replication, this variable determines how row images are written to the binary log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.
              - `BINLOG_ROW_IMAGE_UNSPECIFIED`
              - `FULL`
              - `MINIMAL`
              - `NOBLOB`
            type: string
            enum:
              - BINLOG_ROW_IMAGE_UNSPECIFIED
              - FULL
              - MINIMAL
              - NOBLOB
          binlogRowsQueryLogEvents:
            description: |-
              **boolean**
              When enabled, it causes the server to write informational log events such as row query log events into its binary log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details.
            type: boolean
          rplSemiSyncMasterWaitForSlaveCount:
            description: |-
              **string** (int64)
              The number of replica acknowledgments the source must receive per transaction before proceeding.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details.
            type: string
            format: int64
          slaveParallelType:
            description: |-
              **enum** (SlaveParallelType)
              When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.
              - `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
              - `DATABASE`
              - `LOGICAL_CLOCK`
            type: string
            enum:
              - SLAVE_PARALLEL_TYPE_UNSPECIFIED
              - DATABASE
              - LOGICAL_CLOCK
          slaveParallelWorkers:
            description: |-
              **string** (int64)
              Sets the number of applier threads for executing replication transactions in parallel.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details.
            type: string
            format: int64
          regexpTimeLimit:
            description: |-
              **string** (int64)
              The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit) for details.
            type: string
            format: int64
          mdbPreserveBinlogBytes:
            description: |-
              **string** (int64)
              The size of the binary log to hold.
            type: string
            format: int64
          interactiveTimeout:
            description: |-
              **string** (int64)
              The number of seconds the server waits for activity on an interactive connection before closing it.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout) for details.
            type: string
            format: int64
          waitTimeout:
            description: |-
              **string** (int64)
              The number of seconds the server waits for activity on a noninteractive connection before closing it.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout) for details.
            type: string
            format: int64
          mdbOfflineModeEnableLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
            type: string
            format: int64
          mdbOfflineModeDisableLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
              Should be less than mdb_offline_mode_enable_lag.
            type: string
            format: int64
          rangeOptimizerMaxMemSize:
            description: |-
              **string** (int64)
              The limit on memory consumption for the range optimizer.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details.
            type: string
            format: int64
          slowQueryLog:
            description: |-
              **boolean**
              Manages slow query log.
              See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details.
            type: boolean
          slowQueryLogAlwaysWriteTime:
            description: |-
              **number** (double)
              Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit` will not apply to it.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details.
            type: number
            format: double
          logSlowRateType:
            description: |-
              **enum** (LogSlowRateType)
              Specifies slow log granularity for `log_slow_rate_limit` QUERY or SESSION value.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.
              - `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
              - `SESSION`
              - `QUERY`
            type: string
            enum:
              - LOG_SLOW_RATE_TYPE_UNSPECIFIED
              - SESSION
              - QUERY
          logSlowRateLimit:
            description: |-
              **string** (int64)
              Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details.
            type: string
            format: int64
          logSlowSpStatements:
            description: |-
              **boolean**
              When TRUE, statements executed by stored procedures are logged to the slow log.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details.
            type: boolean
          logSlowFilter:
            description: |-
              **enum** (LogSlowFilterType)
              Filters the slow log by the query's execution plan.
              See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.
              - `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
              - `FULL_SCAN`
              - `FULL_JOIN`
              - `TMP_TABLE`
              - `TMP_TABLE_ON_DISK`
              - `FILESORT`
              - `FILESORT_ON_DISK`
            type: array
            items:
              type: string
              enum:
                - LOG_SLOW_FILTER_TYPE_UNSPECIFIED
                - FULL_SCAN
                - FULL_JOIN
                - TMP_TABLE
                - TMP_TABLE_ON_DISK
                - FILESORT
                - FILESORT_ON_DISK
          mdbPriorityChoiceMaxLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
              Should be less than mdb_offline_mode_disable_lag.
            type: string
            format: int64
          innodbPageSize:
            description: |-
              **string** (int64)
              Specifies the page size for InnoDB tablespaces.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size).
            type: string
            format: int64
          innodbOnlineAlterLogMaxSize:
            description: |-
              **string** (int64)
              The limit in bytes on the size of the temporary log files used during online DDL operations
              See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size) for details.
            type: string
            format: int64
          innodbFtMinTokenSize:
            description: |-
              **string** (int64)
              Minimum length of words that are stored in an InnoDB FULLTEXT index
              See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size) for details.
            type: string
            format: int64
          innodbFtMaxTokenSize:
            description: |-
              **string** (int64)
              Maximum length of words that are stored in an InnoDB FULLTEXT index
              See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size) for details.
            type: string
            format: int64
          lowerCaseTableNames:
            description: |-
              **string** (int64)
              Table names storage and comparison strategy
              See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names) for details.
            type: string
            format: int64
          maxSpRecursionDepth:
            description: |-
              **string** (int64)
              The number of times that any given stored procedure may be called recursively.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth).
            type: string
            format: int64
          innodbCompressionLevel:
            description: |-
              **string** (int64)
              The level of zlib compression to use for InnoDB compressed tables and indexes.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level).
            type: string
            format: int64
          binlogTransactionDependencyTracking:
            description: |-
              **enum** (BinlogTransactionDependencyTracking)
              Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).
              - `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
              - `COMMIT_ORDER`
              - `WRITESET`
              - `WRITESET_SESSION`
            type: string
            enum:
              - BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED
              - COMMIT_ORDER
              - WRITESET
              - WRITESET_SESSION
          autocommit:
            description: |-
              **boolean**
              Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit).
            type: boolean
          innodbStatusOutput:
            description: |-
              **boolean**
              Enables or disables periodic output for the standard InnoDB Monitor.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output).
            type: boolean
          innodbStrictMode:
            description: |-
              **boolean**
              When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode).
            type: boolean
          innodbPrintLockWaitTimeoutInfo:
            description: |-
              **boolean**
              Makes InnoDB to write information about all lock wait timeout errors into the log file.
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info).
            type: boolean
          logErrorVerbosity:
            description: |-
              **string** (int64)
              System variable specifies the verbosity for handling events intended for the error log
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity).
            type: string
            format: int64
          maxDigestLength:
            description: |-
              **string** (int64)
              The maximum number of bytes of memory reserved per session for computation of normalized statement digests.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length).
            type: string
            format: int64
          lockWaitTimeout:
            description: |-
              **string** (int64)
              This variable specifies the timeout in seconds for attempts to acquire metadata locks
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout).
            type: string
            format: int64
          maxPreparedStmtCount:
            description: |-
              **string** (int64)
              This variable limits the total number of prepared statements in the server.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count).
            type: string
            format: int64
          optimizerSwitch:
            description: |-
              **string**
              The system variable enables control over optimizer behavior.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_optimizer_switch)
              https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html
            type: string
          optimizerSearchDepth:
            description: |-
              **string** (int64)
              The maximum depth of search performed by the query optimizer
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html)
            type: string
            format: int64
          userstat:
            description: |-
              **boolean**
              Enables or disables collection of statistics
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/user_stats.html#userstat).
            type: boolean
          maxExecutionTime:
            description: |-
              **string** (int64)
              The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_execution_time)
            type: string
            format: int64
          auditLogPolicy:
            description: |-
              **enum** (AuditLogPolicy)
              The policy controlling how the audit log plugin writes events to its log file
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#sysvar_audit_log_policy)
              - `AUDIT_LOG_POLICY_UNSPECIFIED`
              - `ALL`
              - `LOGINS`
              - `QUERIES`
              - `NONE`
            type: string
            enum:
              - AUDIT_LOG_POLICY_UNSPECIFIED
              - ALL
              - LOGINS
              - QUERIES
              - NONE
          replicationSenderObserveCommitOnly:
            description: |-
              **boolean**
              Limit callbacks to improve performance for semisynchronous replication
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only).
            type: boolean
          replicationOptimizeForStaticPluginConfig:
            description: |-
              **boolean**
              Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config).
            type: boolean
          innodbLruScanDepth:
            description: |-
              **string** (int64)
              A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth)
            type: string
            format: int64
          sqlRequirePrimaryKey:
            description: |-
              **boolean**
              Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sql_require_primary_key).
            type: boolean
          mdbForceSsl:
            description: |-
              **boolean**
              Force ssl on all hosts (require_secure_transport)
            type: boolean
          innodbChangeBuffering:
            description: |-
              **enum** (InnodbChangeBuffering)
              An optimization for change buffering
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_change_buffering).
              - `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
              - `INNODB_CHANGE_BUFFERING_NONE`
              - `INNODB_CHANGE_BUFFERING_INSERTS`
              - `INNODB_CHANGE_BUFFERING_DELETES`
              - `INNODB_CHANGE_BUFFERING_CHANGES`
              - `INNODB_CHANGE_BUFFERING_PURGES`
              - `INNODB_CHANGE_BUFFERING_ALL`
            type: string
            enum:
              - INNODB_CHANGE_BUFFERING_UNSPECIFIED
              - INNODB_CHANGE_BUFFERING_NONE
              - INNODB_CHANGE_BUFFERING_INSERTS
              - INNODB_CHANGE_BUFFERING_DELETES
              - INNODB_CHANGE_BUFFERING_CHANGES
              - INNODB_CHANGE_BUFFERING_PURGES
              - INNODB_CHANGE_BUFFERING_ALL
          maxWriteLockCount:
            description: |-
              **string** (int64)
              Permit some pending read lock requests interval
              P.S. Should be UInt64, but java fails to handle UInt64 limits
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_write_lock_count).
            type: string
            format: int64
      MysqlConfig8_4:
        type: object
        properties:
          innodbBufferPoolSize:
            description: |-
              **string** (int64)
              Size of the InnoDB buffer pool used for caching table and index data.
              For details, see [MySQL documentation for the parameter](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size).
            type: string
            format: int64
          maxConnections:
            description: |-
              **string** (int64)
              The maximum permitted number of simultaneous client connections.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_connections).
            type: string
            format: int64
          longQueryTime:
            description: |-
              **number** (double)
              Time that it takes to process a query before it is considered slow.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_long_query_time).
            type: number
            format: double
          auditLog:
            description: |-
              **boolean**
              Enable writing of audit log of MySQL.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/audit-log-reference.html#audit-log-options-variables).
            type: boolean
          sqlMode:
            description: |-
              **enum** (SQLMode)
              Server SQL mode of MySQL.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/sql-mode.html#sql-mode-setting).
              - `SQLMODE_UNSPECIFIED`
              - `ALLOW_INVALID_DATES`
              - `ANSI_QUOTES`
              - `ERROR_FOR_DIVISION_BY_ZERO`
              - `HIGH_NOT_PRECEDENCE`
              - `IGNORE_SPACE`
              - `NO_AUTO_VALUE_ON_ZERO`
              - `NO_BACKSLASH_ESCAPES`
              - `NO_ENGINE_SUBSTITUTION`
              - `NO_UNSIGNED_SUBTRACTION`
              - `NO_ZERO_DATE`
              - `NO_ZERO_IN_DATE`
              - `NO_FIELD_OPTIONS`
              - `NO_KEY_OPTIONS`
              - `NO_TABLE_OPTIONS`
              - `ONLY_FULL_GROUP_BY`
              - `PAD_CHAR_TO_FULL_LENGTH`
              - `PIPES_AS_CONCAT`
              - `REAL_AS_FLOAT`
              - `STRICT_ALL_TABLES`
              - `STRICT_TRANS_TABLES`
              - `ANSI`
              - `TRADITIONAL`
              - `DB2`
              - `MAXDB`
              - `MSSQL`
              - `MYSQL323`
              - `MYSQL40`
              - `ORACLE`
              - `POSTGRESQL`
              - `NO_AUTO_CREATE_USER`
              - `NO_DIR_IN_CREATE`
            type: array
            items:
              type: string
              enum:
                - SQLMODE_UNSPECIFIED
                - ALLOW_INVALID_DATES
                - ANSI_QUOTES
                - ERROR_FOR_DIVISION_BY_ZERO
                - HIGH_NOT_PRECEDENCE
                - IGNORE_SPACE
                - NO_AUTO_VALUE_ON_ZERO
                - NO_BACKSLASH_ESCAPES
                - NO_ENGINE_SUBSTITUTION
                - NO_UNSIGNED_SUBTRACTION
                - NO_ZERO_DATE
                - NO_ZERO_IN_DATE
                - NO_FIELD_OPTIONS
                - NO_KEY_OPTIONS
                - NO_TABLE_OPTIONS
                - ONLY_FULL_GROUP_BY
                - PAD_CHAR_TO_FULL_LENGTH
                - PIPES_AS_CONCAT
                - REAL_AS_FLOAT
                - STRICT_ALL_TABLES
                - STRICT_TRANS_TABLES
                - ANSI
                - TRADITIONAL
                - DB2
                - MAXDB
                - MSSQL
                - MYSQL323
                - MYSQL40
                - ORACLE
                - POSTGRESQL
                - NO_AUTO_CREATE_USER
                - NO_DIR_IN_CREATE
          maxAllowedPacket:
            description: |-
              **string** (int64)
              The maximum size in bytes of one packet.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_allowed_packet).
            type: string
            format: int64
          innodbFlushLogAtTrxCommit:
            description: |-
              **string** (int64)
              Transaction log flush behaviour.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit)
            type: string
            format: int64
          innodbLockWaitTimeout:
            description: |-
              **string** (int64)
              Max time in seconds for a transaction to wait for a row lock
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout)
            type: string
            format: int64
          transactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Default transaction isolation level.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_transaction_isolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `READ_COMMITTED`
              - `REPEATABLE_READ`
              - `SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - READ_COMMITTED
              - REPEATABLE_READ
              - SERIALIZABLE
          innodbPrintAllDeadlocks:
            description: |-
              **boolean**
              Print information about deadlocks in error log
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks)
            type: boolean
          netReadTimeout:
            description: |-
              **string** (int64)
              The number of seconds to wait for more data from a connection before aborting the read.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_read_timeout)
            type: string
            format: int64
          netWriteTimeout:
            description: |-
              **string** (int64)
              The number of seconds to wait for a block to be written to a connection before aborting the write.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_write_timeout)
            type: string
            format: int64
          groupConcatMaxLen:
            description: |-
              **string** (int64)
              The maximum permitted result length in bytes for the GROUP_CONCAT() function.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_group_concat_max_len)
            type: string
            format: int64
          tmpTableSize:
            description: |-
              **string** (int64)
              The maximum size of internal in-memory temporary tables.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_tmp_table_size)
            type: string
            format: int64
          maxHeapTableSize:
            description: |-
              **string** (int64)
              This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_heap_table_size)
            type: string
            format: int64
          defaultTimeZone:
            description: |-
              **string**
              The servers default time zone.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-options.html#option_mysqld_default-time-zone)
            default: time-zone)
            type: string
          characterSetServer:
            description: |-
              **string**
              The servers default character set.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_character_set_server)
            type: string
          collationServer:
            description: |-
              **string**
              Set the default server collation.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_collation_server)
            type: string
          innodbAdaptiveHashIndex:
            description: |-
              **boolean**
              Enables Innodb adaptive hash index
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index)
            type: boolean
          innodbNumaInterleave:
            description: |-
              **boolean**
              Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_numa_interleave)
            type: boolean
          innodbLogBufferSize:
            description: |-
              **string** (int64)
              The size in bytes of the buffer that InnoDB uses to write to the log files on disk.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_log_buffer_size)
            type: string
            format: int64
          innodbLogFileSize:
            description: |-
              **string** (int64)
              The size in bytes of the single Innodb Redo log file.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_log_file_size)
            type: string
            format: int64
          innodbIoCapacity:
            description: |-
              **string** (int64)
              Limits IO available for InnoDB background tasks
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_io_capacity)
            type: string
            format: int64
          innodbIoCapacityMax:
            description: |-
              **string** (int64)
              Limits IO available for InnoDB background tasks
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_io_capacity_max)
            type: string
            format: int64
          innodbReadIoThreads:
            description: |-
              **string** (int64)
              The number of I/O threads for read operations in InnoDB.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_read_io_threads)
            type: string
            format: int64
          innodbWriteIoThreads:
            description: |-
              **string** (int64)
              The number of I/O threads for write operations in InnoDB.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_write_io_threads)
            type: string
            format: int64
          innodbPurgeThreads:
            description: |-
              **string** (int64)
              The number of background threads devoted to the InnoDB purge operation.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_purge_threads)
            type: string
            format: int64
          innodbThreadConcurrency:
            description: |-
              **string** (int64)
              Defines the maximum number of threads permitted inside of InnoDB.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_thread_concurrency)
            type: string
            format: int64
          innodbTempDataFileMaxSize:
            description: |-
              **string** (int64)
              Limits the max size of InnoDB temp tablespace
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path)
            type: string
            format: int64
          threadCacheSize:
            description: |-
              **string** (int64)
              How many threads the server should cache for reuse.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_thread_cache_size).
            type: string
            format: int64
          threadStack:
            description: |-
              **string** (int64)
              The stack size for each thread. The default is large enough for normal operation.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_thread_stack).
            type: string
            format: int64
          joinBufferSize:
            description: |-
              **string** (int64)
              The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_join_buffer_size).
            type: string
            format: int64
          sortBufferSize:
            description: |-
              **string** (int64)
              Each session that must perform a sort allocates a buffer of this size.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_sort_buffer_size).
            type: string
            format: int64
          tableDefinitionCache:
            description: |-
              **string** (int64)
              The number of table definitions that can be stored in the definition cache.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_definition_cache).
            type: string
            format: int64
          tableOpenCache:
            description: |-
              **string** (int64)
              The number of open tables for all threads.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_open_cache).
            type: string
            format: int64
          tableOpenCacheInstances:
            description: |-
              **string** (int64)
              The number of open tables cache instances.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_open_cache_instances).
            type: string
            format: int64
          explicitDefaultsForTimestamp:
            description: |-
              **boolean**
              This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp).
            type: boolean
          autoIncrementIncrement:
            description: |-
              **string** (int64)
              Can be used to control the operation of AUTO_INCREMENT columns.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_auto_increment_increment).
            type: string
            format: int64
          autoIncrementOffset:
            description: |-
              **string** (int64)
              Can be used to control the operation of AUTO_INCREMENT columns.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_auto_increment_offset).
            type: string
            format: int64
          syncBinlog:
            description: |-
              **string** (int64)
              Controls how often the MySQL server synchronizes the binary log to disk.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_sync_binlog).
            type: string
            format: int64
          binlogCacheSize:
            description: |-
              **string** (int64)
              The size of the cache to hold changes to the binary log during a transaction.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_cache_size).
            type: string
            format: int64
          binlogGroupCommitSyncDelay:
            description: |-
              **string** (int64)
              Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay).
            type: string
            format: int64
          binlogRowImage:
            description: |-
              **enum** (BinlogRowImage)
              For MySQL row-based replication, this variable determines how row images are written to the binary log.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_row_image).
              - `BINLOG_ROW_IMAGE_UNSPECIFIED`
              - `FULL`
              - `MINIMAL`
              - `NOBLOB`
            type: string
            enum:
              - BINLOG_ROW_IMAGE_UNSPECIFIED
              - FULL
              - MINIMAL
              - NOBLOB
          binlogRowsQueryLogEvents:
            description: |-
              **boolean**
              When enabled, it causes the server to write informational log events such as row query log events into its binary log.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events).
            type: boolean
          rplSemiSyncMasterWaitForSlaveCount:
            description: |-
              **string** (int64)
              The number of replica acknowledgments the source must receive per transaction before proceeding.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count).
            type: string
            format: int64
          slaveParallelType:
            description: |-
              **enum** (SlaveParallelType)
              When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_slave_parallel_type).
              - `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
              - `DATABASE`
              - `LOGICAL_CLOCK`
            type: string
            enum:
              - SLAVE_PARALLEL_TYPE_UNSPECIFIED
              - DATABASE
              - LOGICAL_CLOCK
          slaveParallelWorkers:
            description: |-
              **string** (int64)
              Sets the number of applier threads for executing replication transactions in parallel.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_slave_parallel_workers).
            type: string
            format: int64
          regexpTimeLimit:
            description: |-
              **string** (int64)
              The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_regexp_time_limit).
            type: string
            format: int64
          mdbPreserveBinlogBytes:
            description: |-
              **string** (int64)
              The size of the binary log to hold.
            type: string
            format: int64
          interactiveTimeout:
            description: |-
              **string** (int64)
              The number of seconds the server waits for activity on an interactive connection before closing it.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_interactive_timeout).
            type: string
            format: int64
          waitTimeout:
            description: |-
              **string** (int64)
              The number of seconds the server waits for activity on a noninteractive connection before closing it.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_wait_timeout).
            type: string
            format: int64
          mdbOfflineModeEnableLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
            type: string
            format: int64
          mdbOfflineModeDisableLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
              Should be less than mdb_offline_mode_enable_lag.
            type: string
            format: int64
          rangeOptimizerMaxMemSize:
            description: |-
              **string** (int64)
              The limit on memory consumption for the range optimizer.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size).
            type: string
            format: int64
          innodbOnlineAlterLogMaxSize:
            description: |-
              **string** (int64)
              The limit in bytes on the size of the temporary log files used during online DDL operations
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size).
            type: string
            format: int64
          innodbFtMinTokenSize:
            description: |-
              **string** (int64)
              Minimum length of words that are stored in an InnoDB FULLTEXT index
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size).
            type: string
            format: int64
          innodbFtMaxTokenSize:
            description: |-
              **string** (int64)
              Maximum length of words that are stored in an InnoDB FULLTEXT index
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size).
            type: string
            format: int64
          lowerCaseTableNames:
            description: |-
              **string** (int64)
              Table names storage and comparison strategy
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_lower_case_table_names).
            type: string
            format: int64
          slowQueryLog:
            description: |-
              **boolean**
              Manages slow query log
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_slow_query_log).
            type: boolean
          slowQueryLogAlwaysWriteTime:
            description: |-
              **number** (double)
              Query execution time, after which query to be logged unconditionally, that is, log_slow_rate_limit will not apply to it
              For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#slow_query_log_always_write_time).
            type: number
            format: double
          logSlowRateType:
            description: |-
              **enum** (LogSlowRateType)
              Specifies slow log granularity for log_slow_rate_limit: QUERY or SESSION
              For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_rate_type).
              - `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
              - `SESSION`
              - `QUERY`
            type: string
            enum:
              - LOG_SLOW_RATE_TYPE_UNSPECIFIED
              - SESSION
              - QUERY
          logSlowRateLimit:
            description: |-
              **string** (int64)
              Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.
              For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_rate_limit).
            type: string
            format: int64
          logSlowSpStatements:
            description: |-
              **boolean**
              When TRUE, statements executed by stored procedures are logged to the slow log
              For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_sp_statements).
            type: boolean
          logSlowFilter:
            description: |-
              **enum** (LogSlowFilterType)
              Filters the slow log by the query's execution plan
              For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_filter).
              - `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
              - `FULL_SCAN`
              - `FULL_JOIN`
              - `TMP_TABLE`
              - `TMP_TABLE_ON_DISK`
              - `FILESORT`
              - `FILESORT_ON_DISK`
            type: array
            items:
              type: string
              enum:
                - LOG_SLOW_FILTER_TYPE_UNSPECIFIED
                - FULL_SCAN
                - FULL_JOIN
                - TMP_TABLE
                - TMP_TABLE_ON_DISK
                - FILESORT
                - FILESORT_ON_DISK
          mdbPriorityChoiceMaxLag:
            description: |-
              **string** (int64)
              Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
              Should be less than mdb_offline_mode_disable_lag.
            type: string
            format: int64
          innodbPageSize:
            description: |-
              **string** (int64)
              Specifies the page size for InnoDB tablespaces.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_page_size).
            type: string
            format: int64
          maxSpRecursionDepth:
            description: |-
              **string** (int64)
              The number of times that any given stored procedure may be called recursively.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_sp_recursion_depth).
            type: string
            format: int64
          innodbCompressionLevel:
            description: |-
              **string** (int64)
              The level of zlib compression to use for InnoDB compressed tables and indexes.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_compression_level).
            type: string
            format: int64
          autocommit:
            description: |-
              **boolean**
              Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_autocommit).
            type: boolean
          innodbStatusOutput:
            description: |-
              **boolean**
              Enables or disables periodic output for the standard InnoDB Monitor.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_status_output).
            type: boolean
          innodbStrictMode:
            description: |-
              **boolean**
              When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_strict_mode).
            type: boolean
          innodbPrintLockWaitTimeoutInfo:
            description: |-
              **boolean**
              Makes InnoDB to write information about all lock wait timeout errors into the log file.
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.4/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info).
            type: boolean
          logErrorVerbosity:
            description: |-
              **string** (int64)
              System variable specifies the verbosity for handling events intended for the error log
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_log_error_verbosity).
            type: string
            format: int64
          maxDigestLength:
            description: |-
              **string** (int64)
              The maximum number of bytes of memory reserved per session for computation of normalized statement digests.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_digest_length).
            type: string
            format: int64
          lockWaitTimeout:
            description: |-
              **string** (int64)
              This variable specifies the timeout in seconds for attempts to acquire metadata locks
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_lock_wait_timeout).
            type: string
            format: int64
          maxPreparedStmtCount:
            description: |-
              **string** (int64)
              This variable limits the total number of prepared statements in the server.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_prepared_stmt_count).
            type: string
            format: int64
          optimizerSwitch:
            description: |-
              **string**
              The system variable enables control over optimizer behavior.
              For details, see [MySQL documentation for the variable]
              https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_optimizer_switch
              https://dev.mysql.com/doc/refman/8.4/en/switchable-optimizations.html
            type: string
          optimizerSearchDepth:
            description: |-
              **string** (int64)
              The maximum depth of search performed by the query optimizer
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html)
            type: string
            format: int64
          userstat:
            description: |-
              **boolean**
              Enables or disables collection of statistics
              For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.4/diagnostics/user_stats.html#userstat).
            type: boolean
          maxExecutionTime:
            description: |-
              **string** (int64)
              The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_execution_time)
            type: string
            format: int64
          auditLogPolicy:
            description: |-
              **enum** (AuditLogPolicy)
              The policy controlling how the audit log plugin writes events to its log file
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/audit-log-reference.html#sysvar_audit_log_policy)
              - `AUDIT_LOG_POLICY_UNSPECIFIED`
              - `ALL`
              - `LOGINS`
              - `QUERIES`
              - `NONE`
            type: string
            enum:
              - AUDIT_LOG_POLICY_UNSPECIFIED
              - ALL
              - LOGINS
              - QUERIES
              - NONE
          replicationSenderObserveCommitOnly:
            description: |-
              **boolean**
              Limit callbacks to improve performance for semisynchronous replication
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only).
            type: boolean
          replicationOptimizeForStaticPluginConfig:
            description: |-
              **boolean**
              Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config).
            type: boolean
          innodbLruScanDepth:
            description: |-
              **string** (int64)
              A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool
              For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth)
            type: string
            format: int64
          sqlRequirePrimaryKey:
            description: |-
              **boolean**
              Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_sql_require_primary_key).
            type: boolean
          mdbUseAsyncReplication:
            description: |-
              **boolean**
              Enable async replication
            type: boolean
          mdbAsyncAllowedLag:
            description: |-
              **string** (int64)
              Async replication allowed lag (seconds)
            type: string
            format: int64
          mdbForceSsl:
            description: |-
              **boolean**
              Force ssl on all hosts (require_secure_transport)
            type: boolean
          innodbChangeBuffering:
            description: |-
              **enum** (InnodbChangeBuffering)
              An optimization for change buffering
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_change_buffering).
              - `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
              - `INNODB_CHANGE_BUFFERING_NONE`
              - `INNODB_CHANGE_BUFFERING_INSERTS`
              - `INNODB_CHANGE_BUFFERING_DELETES`
              - `INNODB_CHANGE_BUFFERING_CHANGES`
              - `INNODB_CHANGE_BUFFERING_PURGES`
              - `INNODB_CHANGE_BUFFERING_ALL`
            type: string
            enum:
              - INNODB_CHANGE_BUFFERING_UNSPECIFIED
              - INNODB_CHANGE_BUFFERING_NONE
              - INNODB_CHANGE_BUFFERING_INSERTS
              - INNODB_CHANGE_BUFFERING_DELETES
              - INNODB_CHANGE_BUFFERING_CHANGES
              - INNODB_CHANGE_BUFFERING_PURGES
              - INNODB_CHANGE_BUFFERING_ALL
          maxWriteLockCount:
            description: |-
              **string** (int64)
              Permit some pending read lock requests interval
              P.S. Should be UInt64, but java fails to handle UInt64 limits
              For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_write_lock_count).
            type: string
            format: int64
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.
              All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types).
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage (for each cluster host, in bytes).
            type: string
            format: int64
          diskTypeId:
            description: |-
              **string**
              Type of the storage.
              Possible values:
              * `network-hdd` - standard network storage
              * `network-ssd` - fast network storage
              * `network-ssd-nonreplicated` - fast network nonreplicated storage
              * `local-ssd` - fast local storage.
              See [the documentation](/docs/managed-mysql/concepts/storage) for details.
            type: string
      TimeOfDay:
        type: object
        properties:
          hours:
            description: |-
              **integer** (int32)
              Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
              to allow the value "24:00:00" for scenarios like business closing time.
            type: integer
            format: int32
          minutes:
            description: |-
              **integer** (int32)
              Minutes of hour of day. Must be from 0 to 59.
            type: integer
            format: int32
          seconds:
            description: |-
              **integer** (int32)
              Seconds of minutes of the time. Must normally be from 0 to 59. An API may
              allow the value 60 if it allows leap-seconds.
            type: integer
            format: int32
          nanos:
            description: |-
              **integer** (int32)
              Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
            type: integer
            format: int32
      Access:
        type: object
        properties:
          dataLens:
            description: |-
              **boolean**
              Allows access from DataLens.
              See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details.
            type: boolean
          webSql:
            description: |-
              **boolean**
              Allows SQL queries to the cluster databases from management console.
              See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details.
            type: boolean
          dataTransfer:
            description: |-
              **boolean**
              Allow access for DataTransfer.
            type: boolean
          yandexQuery:
            description: |-
              **boolean**
              Allow access for YandexQuery.
            type: boolean
      PerformanceDiagnostics:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Flag that shows if performance statistics gathering is enabled for the cluster.
            type: boolean
          sessionsSamplingInterval:
            description: |-
              **string** (int64)
              Interval (in seconds) for `my_session` sampling.
            type: string
            format: int64
          statementsSamplingInterval:
            description: |-
              **string** (int64)
              Interval (in seconds) for `my_statements` sampling.
            type: string
            format: int64
      DiskSizeAutoscaling:
        type: object
        properties:
          plannedUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
            type: string
            format: int64
          emergencyUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.
            type: string
            format: int64
          diskSizeLimit:
            description: |-
              **string** (int64)
              Limit on how large the storage for database instances can automatically grow, in bytes.
            type: string
            format: int64
      ConfigSpec:
        type: object
        properties:
          version:
            description: |-
              **string**
              Version of MySQL used in the cluster.
              Possible values: `5.7`, `8.0`, `8.4`.
            type: string
          mysqlConfig_5_7:
            description: |-
              **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)**
              Configuration for a MySQL 5.7 cluster.
              Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.
              Cluster-wide MySQL configuration.
            $ref: '#/definitions/MysqlConfig5_7'
          mysqlConfig_8_0:
            description: |-
              **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)**
              Configuration for a MySQL 8.0 cluster.
              Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.
              Cluster-wide MySQL configuration.
            $ref: '#/definitions/MysqlConfig8_0'
          mysqlConfig_8_4:
            description: |-
              **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4)**
              Configuration for a MySQL 8.4 cluster.
              Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.
              Cluster-wide MySQL configuration.
            $ref: '#/definitions/MysqlConfig8_4'
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.mysql.v1.Resources)**
              Resource preset for the cluster hosts.
            $ref: '#/definitions/Resources'
          backupWindowStart:
            description: |-
              **[TimeOfDay](#google.type.TimeOfDay)**
              Time to start the daily backup, in the UTC timezone.
            $ref: '#/definitions/TimeOfDay'
          access:
            description: |-
              **[Access](#yandex.cloud.mdb.mysql.v1.Access)**
              Access policy for external services.
              If the specific services need to access the cluster, then set the necessary values in this policy.
            $ref: '#/definitions/Access'
          performanceDiagnostics:
            description: |-
              **[PerformanceDiagnostics](#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics)**
              Configuration of the performance diagnostics service.
            $ref: '#/definitions/PerformanceDiagnostics'
          backupRetainPeriodDays:
            description: |-
              **string** (int64)
              Retention policy of automated backups.
            type: string
            format: int64
          diskSizeAutoscaling:
            description: |-
              **[DiskSizeAutoscaling](#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling)**
              Disk size autoscaling
            $ref: '#/definitions/DiskSizeAutoscaling'
        oneOf:
          - required:
              - mysqlConfig_5_7
          - required:
              - mysqlConfig_8_0
          - required:
              - mysqlConfig_8_4
      DatabaseSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the database.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
        required:
          - name
      Permission:
        type: object
        properties:
          databaseName:
            description: |-
              **string**
              Name of the database that the permission grants access to.
            type: string
          roles:
            description: |-
              **enum** (Privilege)
              Roles granted to the user within the database.
              See [the documentation](/docs/managed-mysql/operations/grant) for details.
              - `PRIVILEGE_UNSPECIFIED`
              - `ALL_PRIVILEGES`: All privileges that can be made available to the user.
              - `ALTER`: Altering tables.
              - `ALTER_ROUTINE`: Altering stored routines and functions.
              - `CREATE`: Creating tables or indexes.
              - `CREATE_ROUTINE`: Creating stored routines.
              - `CREATE_TEMPORARY_TABLES`: Creating temporary tables.
              - `CREATE_VIEW`: Creating views.
              - `DELETE`: Deleting tables.
              - `DROP`: Removing tables or views.
              - `EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.
              - `EXECUTE`: Executing stored routines.
              - `INDEX`: Creating and removing indexes.
              - `INSERT`: Inserting rows into the database.
              - `LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.
              - `SELECT`: Selecting rows from tables.
                Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege.
                See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.
              - `SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.
              - `TRIGGER`: Creating, removing, executing, or displaying triggers for a table.
              - `UPDATE`: Updating rows in the database.
              - `REFERENCES`: Creation of a foreign key constraint for the parent table.
            type: array
            items:
              type: string
              enum:
                - PRIVILEGE_UNSPECIFIED
                - ALL_PRIVILEGES
                - ALTER
                - ALTER_ROUTINE
                - CREATE
                - CREATE_ROUTINE
                - CREATE_TEMPORARY_TABLES
                - CREATE_VIEW
                - DELETE
                - DROP
                - EVENT
                - EXECUTE
                - INDEX
                - INSERT
                - LOCK_TABLES
                - SELECT
                - SHOW_VIEW
                - TRIGGER
                - UPDATE
                - REFERENCES
      ConnectionLimits:
        type: object
        properties:
          maxQuestionsPerHour:
            description: |-
              **string** (int64)
              The maximum permitted number of user questions per hour.
            type: string
            format: int64
          maxUpdatesPerHour:
            description: |-
              **string** (int64)
              The maximum permitted number of user updates per hour.
            type: string
            format: int64
          maxConnectionsPerHour:
            description: |-
              **string** (int64)
              The maximum permitted number of simultaneous client connections per hour.
            type: string
            format: int64
          maxUserConnections:
            description: |-
              **string** (int64)
              The maximum number of simultaneous connections permitted to any given MySQL user account.
            type: string
            format: int64
      UserSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the user.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          password:
            description: |-
              **string**
              Required field. Password of the user.
            type: string
          permissions:
            description: |-
              **[Permission](#yandex.cloud.mdb.mysql.v1.Permission)**
              Set of permissions granted to the user to access specific databases.
              One permission per database.
              When a permission for a database is set, the user will have access to the database.
            type: array
            items:
              $ref: '#/definitions/Permission'
          globalPermissions:
            description: |-
              **enum** (GlobalPermission)
              Set of global permissions to grant to the user.
              - `GLOBAL_PERMISSION_UNSPECIFIED`
              - `REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.
              - `REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server,
              using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.
              - `PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).
                The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users.
              You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.
              - `FLUSH_OPTIMIZER_COSTS`: Enables use of the `FLUSH OPTIMIZER_COSTS` statement.
              - `SHOW_ROUTINE`: Enables a user to access definitions and properties of all stored routines (stored procedures and functions), even those for which the user is not named as the routine DEFINER.
              This access includes:
              The contents of the Information Schema `ROUTINES` table.
              The `SHOW CREATE FUNCTION` and `SHOW CREATE PROCEDURE` statements.
              The `SHOW FUNCTION CODE` and `SHOW PROCEDURE CODE` statements.
              The SHOW `FUNCTION STATUS` and `SHOW PROCEDURE STATUS` statements.
              - `MDB_ADMIN`: Enables use of the KILL command, creating and dropping databases and users, granting privileges to tables and databases.
            type: array
            items:
              type: string
              enum:
                - GLOBAL_PERMISSION_UNSPECIFIED
                - REPLICATION_CLIENT
                - REPLICATION_SLAVE
                - PROCESS
                - FLUSH_OPTIMIZER_COSTS
                - SHOW_ROUTINE
                - MDB_ADMIN
          connectionLimits:
            description: |-
              **[ConnectionLimits](#yandex.cloud.mdb.mysql.v1.ConnectionLimits)**
              Set of user connection limits.
            $ref: '#/definitions/ConnectionLimits'
          authenticationPlugin:
            description: |-
              **enum** (AuthPlugin)
              User authentication plugin.
              - `AUTH_PLUGIN_UNSPECIFIED`
              - `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
              - `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
              - `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
              - `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
              - `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/).
            type: string
            enum:
              - AUTH_PLUGIN_UNSPECIFIED
              - MYSQL_NATIVE_PASSWORD
              - CACHING_SHA2_PASSWORD
              - SHA256_PASSWORD
              - MYSQL_NO_LOGIN
              - MDB_IAMPROXY_AUTH
          generatePassword:
            description: |-
              **boolean**
              Generate password using Connection Manager.
            type: boolean
        required:
          - name
          - password
      HostSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              ID of the availability zone where the host resides.
              To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet to assign to the host.
              This subnet should be a part of the cluster network (the network ID is specified in the `ClusterService.CreateClusterRequest.networkId`).
            type: string
          assignPublicIp:
            description: |-
              **boolean**
              Option that enables public IP address for the host so that the host can be accessed from the internet.
              After a host has been created, this setting cannot be changed.
              To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate [assignPublicIp](/docs/managed-mysql/api-ref/Cluster/updateHosts#yandex.cloud.mdb.mysql.v1.UpdateHostSpec) value set.
              Possible values:
              * `false` - don't assign a public IP address to the host.
              * `true` - assign a public IP address to the host.
            type: boolean
          replicationSource:
            description: |-
              **string**
              [Host.name](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) of the host to be used as the replication source (for cascading replication).
            type: string
          backupPriority:
            description: |-
              **string** (int64)
              Host backup priority
            type: string
            format: int64
          priority:
            description: |-
              **string** (int64)
              Host master promotion priority
            type: string
            format: int64
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week (in `DDD` format).
              - `WEEK_DAY_UNSPECIFIED`
              - `MON`
              - `TUE`
              - `WED`
              - `THU`
              - `FRI`
              - `SAT`
              - `SUN`
            type: string
            enum:
              - WEEK_DAY_UNSPECIFIED
              - MON
              - TUE
              - WED
              - THU
              - FRI
              - SAT
              - SUN
          hour:
            description: |-
              **string** (int64)
              Hour of the day in UTC (in `HH` format).
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              Maintenance operation can be scheduled anytime.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
              The maintenance policy in effect.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow)**
              Maintenance operation can be scheduled on a weekly basis.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
              The maintenance policy in effect.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Cluster/create.md
---

# Managed Service for MySQL API, REST: Cluster.Create

Creates a cluster in a folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mysql/v1/clusters
```

## Body parameters {#yandex.cloud.mdb.mysql.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    // Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`
    "mysqlConfig_5_7": {
      "innodbBufferPoolSize": "string",
      "maxConnections": "string",
      "longQueryTime": "number",
      "generalLog": "boolean",
      "auditLog": "boolean",
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "string",
      "defaultAuthenticationPlugin": "string",
      "innodbFlushLogAtTrxCommit": "string",
      "innodbLockWaitTimeout": "string",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": "boolean",
      "netReadTimeout": "string",
      "netWriteTimeout": "string",
      "groupConcatMaxLen": "string",
      "tmpTableSize": "string",
      "maxHeapTableSize": "string",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": "boolean",
      "innodbNumaInterleave": "boolean",
      "innodbLogBufferSize": "string",
      "innodbLogFileSize": "string",
      "innodbIoCapacity": "string",
      "innodbIoCapacityMax": "string",
      "innodbReadIoThreads": "string",
      "innodbWriteIoThreads": "string",
      "innodbPurgeThreads": "string",
      "innodbThreadConcurrency": "string",
      "innodbTempDataFileMaxSize": "string",
      "threadCacheSize": "string",
      "threadStack": "string",
      "joinBufferSize": "string",
      "sortBufferSize": "string",
      "tableDefinitionCache": "string",
      "tableOpenCache": "string",
      "tableOpenCacheInstances": "string",
      "explicitDefaultsForTimestamp": "boolean",
      "autoIncrementIncrement": "string",
      "autoIncrementOffset": "string",
      "syncBinlog": "string",
      "binlogCacheSize": "string",
      "binlogGroupCommitSyncDelay": "string",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": "boolean",
      "rplSemiSyncMasterWaitForSlaveCount": "string",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "string",
      "mdbPreserveBinlogBytes": "string",
      "interactiveTimeout": "string",
      "waitTimeout": "string",
      "mdbOfflineModeEnableLag": "string",
      "mdbOfflineModeDisableLag": "string",
      "rangeOptimizerMaxMemSize": "string",
      "slowQueryLog": "boolean",
      "slowQueryLogAlwaysWriteTime": "number",
      "logSlowRateType": "string",
      "logSlowRateLimit": "string",
      "logSlowSpStatements": "boolean",
      "logSlowFilter": [
        "string"
      ],
      "mdbPriorityChoiceMaxLag": "string",
      "innodbPageSize": "string",
      "innodbOnlineAlterLogMaxSize": "string",
      "innodbFtMinTokenSize": "string",
      "innodbFtMaxTokenSize": "string",
      "lowerCaseTableNames": "string",
      "showCompatibility_56": "boolean",
      "maxSpRecursionDepth": "string",
      "innodbCompressionLevel": "string",
      "binlogTransactionDependencyTracking": "string",
      "autocommit": "boolean",
      "innodbStatusOutput": "boolean",
      "innodbStrictMode": "boolean",
      "innodbPrintLockWaitTimeoutInfo": "boolean",
      "logErrorVerbosity": "string",
      "maxDigestLength": "string",
      "queryCacheLimit": "string",
      "queryCacheSize": "string",
      "queryCacheType": "string",
      "lockWaitTimeout": "string",
      "maxPreparedStmtCount": "string",
      "optimizerSwitch": "string",
      "optimizerSearchDepth": "string",
      "queryResponseTimeStats": "boolean",
      "userstat": "boolean",
      "maxExecutionTime": "string",
      "auditLogPolicy": "string",
      "innodbLruScanDepth": "string",
      "mdbForceSsl": "boolean",
      "innodbChangeBuffering": "string",
      "maxWriteLockCount": "string"
    },
    "mysqlConfig_8_0": {
      "innodbBufferPoolSize": "string",
      "maxConnections": "string",
      "longQueryTime": "number",
      "generalLog": "boolean",
      "auditLog": "boolean",
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "string",
      "defaultAuthenticationPlugin": "string",
      "innodbFlushLogAtTrxCommit": "string",
      "innodbLockWaitTimeout": "string",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": "boolean",
      "netReadTimeout": "string",
      "netWriteTimeout": "string",
      "groupConcatMaxLen": "string",
      "tmpTableSize": "string",
      "maxHeapTableSize": "string",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": "boolean",
      "innodbNumaInterleave": "boolean",
      "innodbLogBufferSize": "string",
      "innodbLogFileSize": "string",
      "innodbIoCapacity": "string",
      "innodbIoCapacityMax": "string",
      "innodbReadIoThreads": "string",
      "innodbWriteIoThreads": "string",
      "innodbPurgeThreads": "string",
      "innodbThreadConcurrency": "string",
      "innodbTempDataFileMaxSize": "string",
      "threadCacheSize": "string",
      "threadStack": "string",
      "joinBufferSize": "string",
      "sortBufferSize": "string",
      "tableDefinitionCache": "string",
      "tableOpenCache": "string",
      "tableOpenCacheInstances": "string",
      "explicitDefaultsForTimestamp": "boolean",
      "autoIncrementIncrement": "string",
      "autoIncrementOffset": "string",
      "syncBinlog": "string",
      "binlogCacheSize": "string",
      "binlogGroupCommitSyncDelay": "string",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": "boolean",
      "rplSemiSyncMasterWaitForSlaveCount": "string",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "string",
      "regexpTimeLimit": "string",
      "mdbPreserveBinlogBytes": "string",
      "interactiveTimeout": "string",
      "waitTimeout": "string",
      "mdbOfflineModeEnableLag": "string",
      "mdbOfflineModeDisableLag": "string",
      "rangeOptimizerMaxMemSize": "string",
      "slowQueryLog": "boolean",
      "slowQueryLogAlwaysWriteTime": "number",
      "logSlowRateType": "string",
      "logSlowRateLimit": "string",
      "logSlowSpStatements": "boolean",
      "logSlowFilter": [
        "string"
      ],
      "mdbPriorityChoiceMaxLag": "string",
      "innodbPageSize": "string",
      "innodbOnlineAlterLogMaxSize": "string",
      "innodbFtMinTokenSize": "string",
      "innodbFtMaxTokenSize": "string",
      "lowerCaseTableNames": "string",
      "maxSpRecursionDepth": "string",
      "innodbCompressionLevel": "string",
      "binlogTransactionDependencyTracking": "string",
      "autocommit": "boolean",
      "innodbStatusOutput": "boolean",
      "innodbStrictMode": "boolean",
      "innodbPrintLockWaitTimeoutInfo": "boolean",
      "logErrorVerbosity": "string",
      "maxDigestLength": "string",
      "lockWaitTimeout": "string",
      "maxPreparedStmtCount": "string",
      "optimizerSwitch": "string",
      "optimizerSearchDepth": "string",
      "userstat": "boolean",
      "maxExecutionTime": "string",
      "auditLogPolicy": "string",
      "replicationSenderObserveCommitOnly": "boolean",
      "replicationOptimizeForStaticPluginConfig": "boolean",
      "innodbLruScanDepth": "string",
      "sqlRequirePrimaryKey": "boolean",
      "mdbForceSsl": "boolean",
      "innodbChangeBuffering": "string",
      "maxWriteLockCount": "string"
    },
    "mysqlConfig_8_4": {
      "innodbBufferPoolSize": "string",
      "maxConnections": "string",
      "longQueryTime": "number",
      "auditLog": "boolean",
      "sqlMode": [
        "string"
      ],
      "maxAllowedPacket": "string",
      "innodbFlushLogAtTrxCommit": "string",
      "innodbLockWaitTimeout": "string",
      "transactionIsolation": "string",
      "innodbPrintAllDeadlocks": "boolean",
      "netReadTimeout": "string",
      "netWriteTimeout": "string",
      "groupConcatMaxLen": "string",
      "tmpTableSize": "string",
      "maxHeapTableSize": "string",
      "defaultTimeZone": "string",
      "characterSetServer": "string",
      "collationServer": "string",
      "innodbAdaptiveHashIndex": "boolean",
      "innodbNumaInterleave": "boolean",
      "innodbLogBufferSize": "string",
      "innodbLogFileSize": "string",
      "innodbIoCapacity": "string",
      "innodbIoCapacityMax": "string",
      "innodbReadIoThreads": "string",
      "innodbWriteIoThreads": "string",
      "innodbPurgeThreads": "string",
      "innodbThreadConcurrency": "string",
      "innodbTempDataFileMaxSize": "string",
      "threadCacheSize": "string",
      "threadStack": "string",
      "joinBufferSize": "string",
      "sortBufferSize": "string",
      "tableDefinitionCache": "string",
      "tableOpenCache": "string",
      "tableOpenCacheInstances": "string",
      "explicitDefaultsForTimestamp": "boolean",
      "autoIncrementIncrement": "string",
      "autoIncrementOffset": "string",
      "syncBinlog": "string",
      "binlogCacheSize": "string",
      "binlogGroupCommitSyncDelay": "string",
      "binlogRowImage": "string",
      "binlogRowsQueryLogEvents": "boolean",
      "rplSemiSyncMasterWaitForSlaveCount": "string",
      "slaveParallelType": "string",
      "slaveParallelWorkers": "string",
      "regexpTimeLimit": "string",
      "mdbPreserveBinlogBytes": "string",
      "interactiveTimeout": "string",
      "waitTimeout": "string",
      "mdbOfflineModeEnableLag": "string",
      "mdbOfflineModeDisableLag": "string",
      "rangeOptimizerMaxMemSize": "string",
      "innodbOnlineAlterLogMaxSize": "string",
      "innodbFtMinTokenSize": "string",
      "innodbFtMaxTokenSize": "string",
      "lowerCaseTableNames": "string",
      "slowQueryLog": "boolean",
      "slowQueryLogAlwaysWriteTime": "number",
      "logSlowRateType": "string",
      "logSlowRateLimit": "string",
      "logSlowSpStatements": "boolean",
      "logSlowFilter": [
        "string"
      ],
      "mdbPriorityChoiceMaxLag": "string",
      "innodbPageSize": "string",
      "maxSpRecursionDepth": "string",
      "innodbCompressionLevel": "string",
      "autocommit": "boolean",
      "innodbStatusOutput": "boolean",
      "innodbStrictMode": "boolean",
      "innodbPrintLockWaitTimeoutInfo": "boolean",
      "logErrorVerbosity": "string",
      "maxDigestLength": "string",
      "lockWaitTimeout": "string",
      "maxPreparedStmtCount": "string",
      "optimizerSwitch": "string",
      "optimizerSearchDepth": "string",
      "userstat": "boolean",
      "maxExecutionTime": "string",
      "auditLogPolicy": "string",
      "replicationSenderObserveCommitOnly": "boolean",
      "replicationOptimizeForStaticPluginConfig": "boolean",
      "innodbLruScanDepth": "string",
      "sqlRequirePrimaryKey": "boolean",
      "mdbUseAsyncReplication": "boolean",
      "mdbAsyncAllowedLag": "string",
      "mdbForceSsl": "boolean",
      "innodbChangeBuffering": "string",
      "maxWriteLockCount": "string"
    },
    // end of the list of possible fields
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
      "dataLens": "boolean",
      "webSql": "boolean",
      "dataTransfer": "boolean",
      "yandexQuery": "boolean"
    },
    "performanceDiagnostics": {
      "enabled": "boolean",
      "sessionsSamplingInterval": "string",
      "statementsSamplingInterval": "string"
    },
    "backupRetainPeriodDays": "string",
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "string",
      "emergencyUsageThreshold": "string",
      "diskSizeLimit": "string"
    }
  },
  "databaseSpecs": [
    {
      "name": "string"
    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ],
      "globalPermissions": [
        "string"
      ],
      "connectionLimits": {
        "maxQuestionsPerHour": "string",
        "maxUpdatesPerHour": "string",
        "maxConnectionsPerHour": "string",
        "maxUserConnections": "string"
      },
      "authenticationPlugin": "string",
      "generatePassword": "boolean"
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "replicationSource": "string",
      "backupPriority": "string",
      "priority": "string"
    }
  ],
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "hostGroupIds": [
    "string"
  ],
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "diskEncryptionKeyId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the cluster in.

To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Required field. Name of the cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the cluster as `key:value` pairs. ||
|| environment | **enum** (Environment)

Deployment environment of the MySQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Environment for stable versions of your apps.
A conservative update policy is in effect: only bug fixes are applied during regular maintenance.
- `PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself.
This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment.
However, not every update ensures backward compatibility. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.mysql.v1.ConfigSpec)**

Configuration of the cluster. ||
|| databaseSpecs[] | **[DatabaseSpec](#yandex.cloud.mdb.mysql.v1.DatabaseSpec)**

Configuration of databases in the cluster. ||
|| userSpecs[] | **[UserSpec](#yandex.cloud.mdb.mysql.v1.UserSpec)**

Configuration of database users in the cluster. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.mysql.v1.HostSpec)**

Configuration of hosts in the cluster. ||
|| networkId | **string**

ID of the network to create the cluster in. ||
|| securityGroupIds[] | **string**

List of security group IDs to apply to the cluster. ||
|| deletionProtection | **boolean**

This option prevents unintended deletion of the cluster. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.mysql.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## ConfigSpec {#yandex.cloud.mdb.mysql.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of MySQL used in the cluster.

Possible values: `5.7`, `8.0`, `8.4`. ||
|| mysqlConfig_5_7 | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7)**

Configuration for a MySQL 5.7 cluster.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.

Cluster-wide MySQL configuration. ||
|| mysqlConfig_8_0 | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0)**

Configuration for a MySQL 8.0 cluster.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.

Cluster-wide MySQL configuration. ||
|| mysqlConfig_8_4 | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4)**

Configuration for a MySQL 8.4 cluster.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.

Cluster-wide MySQL configuration. ||
|| resources | **[Resources](#yandex.cloud.mdb.mysql.v1.Resources)**

Resource preset for the cluster hosts. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.mysql.v1.Access)**

Access policy for external services.

If the specific services need to access the cluster, then set the necessary values in this policy. ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling)**

Disk size autoscaling ||
|#

## MysqlConfig5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_7}

Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file.

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **boolean**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting) for details.

- `SQLMODE_UNSPECIFIED`
- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `NO_FIELD_OPTIONS`
- `NO_KEY_OPTIONS`
- `NO_TABLE_OPTIONS`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `ANSI`
- `TRADITIONAL`
- `DB2`
- `MAXDB`
- `MSSQL`
- `MYSQL323`
- `MYSQL40`
- `ORACLE`
- `POSTGRESQL`
- `NO_AUTO_CREATE_USER`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size) for details. ||
|| defaultTimeZone | **string**

The servers default time zone.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone) for details. ||
|| characterSetServer | **string**

The servers default character set.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server) for details. ||
|| collationServer | **string**

The server default collation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server) for details. ||
|| innodbAdaptiveHashIndex | **boolean**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **string** (int64)

A number of threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **boolean**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag value. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **boolean**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for `log_slow_rate_limit` values QUERY or SESSION.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size). ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size). ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size). ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names). ||
|| showCompatibility_56 | **boolean**

Manages MySQL 5.6 compatibility

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56). ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_digest_length). ||
|| queryCacheLimit | **string** (int64)

Do not cache results that are larger than this number of bytes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_limit). ||
|| queryCacheSize | **string** (int64)

The amount of memory allocated for caching query results.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_size). ||
|| queryCacheType | **string** (int64)

Set the query cache type.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_type). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html) ||
|| queryResponseTimeStats | **boolean**

Enables and disables collection of query times

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html#query_response_time_stats). ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_execution_time) ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

The policy controlling how the audit log plugin writes events to its log file

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/audit-log-reference.html#sysvar_audit_log_policy)

- `AUDIT_LOG_POLICY_UNSPECIFIED`
- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| innodbLruScanDepth | **string** (int64)

A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth) ||
|| mdbForceSsl | **boolean**

Force ssl on all hosts (require_secure_transport) ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

An optimization for change buffering

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

Permit some pending read lock requests interval
P.S. Should be UInt64, but java fails to handle UInt64 limits

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_write_lock_count). ||
|#

## MysqlConfig8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_0}

Options and structure of `MysqlConfig8_0` reflects MySQL 8.0 configuration file.

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **boolean**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) for details.

- `SQLMODE_UNSPECIFIED`
- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `TIME_TRUNCATE_FRACTIONAL`
- `ANSI`
- `TRADITIONAL`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Using [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size) for details. ||
|| defaultTimeZone | **string**

The servers default time zone.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone) for details. ||
|| characterSetServer | **string**

The servers default character set.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server) for details. ||
|| collationServer | **string**

The server default collation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server) for details. ||
|| innodbAdaptiveHashIndex | **boolean**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **string** (int64)

How many threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **boolean**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| regexpTimeLimit | **string** (int64)

The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit) for details. ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **boolean**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for `log_slow_rate_limit` QUERY or SESSION value.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size) for details. ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size) for details. ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size) for details. ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names) for details. ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_execution_time) ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

The policy controlling how the audit log plugin writes events to its log file

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#sysvar_audit_log_policy)

- `AUDIT_LOG_POLICY_UNSPECIFIED`
- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| replicationSenderObserveCommitOnly | **boolean**

Limit callbacks to improve performance for semisynchronous replication

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only). ||
|| replicationOptimizeForStaticPluginConfig | **boolean**

Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config). ||
|| innodbLruScanDepth | **string** (int64)

A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth) ||
|| sqlRequirePrimaryKey | **boolean**

Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sql_require_primary_key). ||
|| mdbForceSsl | **boolean**

Force ssl on all hosts (require_secure_transport) ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

An optimization for change buffering

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

Permit some pending read lock requests interval
P.S. Should be UInt64, but java fails to handle UInt64 limits

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_write_lock_count). ||
|#

## MysqlConfig8_4 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_4}

Options and structure of `MysqlConfig8_4` reflects MySQL 8.4 configuration file

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

For details, see [MySQL documentation for the parameter](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size). ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_connections). ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_long_query_time). ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/audit-log-reference.html#audit-log-options-variables). ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/sql-mode.html#sql-mode-setting).

- `SQLMODE_UNSPECIFIED`
- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `TIME_TRUNCATE_FRACTIONAL`
- `ANSI`
- `TRADITIONAL`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

The maximum size in bytes of one packet.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_allowed_packet). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_transaction_isolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_read_timeout) ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_write_timeout) ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_group_concat_max_len) ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_tmp_table_size) ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_heap_table_size) ||
|| defaultTimeZone | **string**

The servers default time zone.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-options.html#option_mysqld_default-time-zone) ||
|| characterSetServer | **string**

The servers default character set.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_character_set_server) ||
|| collationServer | **string**

Set the default server collation.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_collation_server) ||
|| innodbAdaptiveHashIndex | **boolean**

Enables Innodb adaptive hash index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_numa_interleave) ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single Innodb Redo log file.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_log_file_size) ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_io_capacity) ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_read_io_threads) ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_write_io_threads) ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_purge_threads) ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) ||
|| threadCacheSize | **string** (int64)

How many threads the server should cache for reuse.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_thread_cache_size). ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_thread_stack). ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_join_buffer_size). ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_sort_buffer_size). ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_definition_cache). ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_open_cache). ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_open_cache_instances). ||
|| explicitDefaultsForTimestamp | **boolean**

This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp). ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_auto_increment_increment). ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_auto_increment_offset). ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_sync_binlog). ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_cache_size). ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay). ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_row_image).

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events). ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count). ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_slave_parallel_type).

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_slave_parallel_workers). ||
|| regexpTimeLimit | **string** (int64)

The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_regexp_time_limit). ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_interactive_timeout). ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_wait_timeout). ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size). ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size). ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size). ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_lower_case_table_names). ||
|| slowQueryLog | **boolean**

Manages slow query log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_slow_query_log). ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, log_slow_rate_limit will not apply to it

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#slow_query_log_always_write_time). ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for log_slow_rate_limit: QUERY or SESSION

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_rate_type).

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_rate_limit). ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_sp_statements). ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_filter).

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.4/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_digest_length). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable]
https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_optimizer_switch
https://dev.mysql.com/doc/refman/8.4/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html) ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.4/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_execution_time) ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

The policy controlling how the audit log plugin writes events to its log file

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/audit-log-reference.html#sysvar_audit_log_policy)

- `AUDIT_LOG_POLICY_UNSPECIFIED`
- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| replicationSenderObserveCommitOnly | **boolean**

Limit callbacks to improve performance for semisynchronous replication

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only). ||
|| replicationOptimizeForStaticPluginConfig | **boolean**

Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config). ||
|| innodbLruScanDepth | **string** (int64)

A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth) ||
|| sqlRequirePrimaryKey | **boolean**

Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_sql_require_primary_key). ||
|| mdbUseAsyncReplication | **boolean**

Enable async replication ||
|| mdbAsyncAllowedLag | **string** (int64)

Async replication allowed lag (seconds) ||
|| mdbForceSsl | **boolean**

Force ssl on all hosts (require_secure_transport) ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

An optimization for change buffering

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

Permit some pending read lock requests interval
P.S. Should be UInt64, but java fails to handle UInt64 limits

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_write_lock_count). ||
|#

## Resources {#yandex.cloud.mdb.mysql.v1.Resources}

Cluster resource preset.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.

All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage (for each cluster host, in bytes). ||
|| diskTypeId | **string**

Type of the storage.

Possible values:
* `network-hdd` - standard network storage
* `network-ssd` - fast network storage
* `network-ssd-nonreplicated` - fast network nonreplicated storage
* `local-ssd` - fast local storage.

See [the documentation](/docs/managed-mysql/concepts/storage) for details. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.mysql.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows access from DataLens.

See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from management console.

See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **boolean**

Flag that shows if performance statistics gathering is enabled for the cluster. ||
|| sessionsSamplingInterval | **string** (int64)

Interval (in seconds) for `my_session` sampling. ||
|| statementsSamplingInterval | **string** (int64)

Interval (in seconds) for `my_statements` sampling. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## DatabaseSpec {#yandex.cloud.mdb.mysql.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the database. ||
|#

## UserSpec {#yandex.cloud.mdb.mysql.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the user. ||
|| password | **string**

Required field. Password of the user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mysql.v1.Permission)**

Set of permissions granted to the user to access specific databases.
One permission per database.

When a permission for a database is set, the user will have access to the database. ||
|| globalPermissions[] | **enum** (GlobalPermission)

Set of global permissions to grant to the user.

- `GLOBAL_PERMISSION_UNSPECIFIED`
- `REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.
- `REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server,
using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.
- `PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).

  The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users.
You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.
- `FLUSH_OPTIMIZER_COSTS`: Enables use of the `FLUSH OPTIMIZER_COSTS` statement.
- `SHOW_ROUTINE`: Enables a user to access definitions and properties of all stored routines (stored procedures and functions), even those for which the user is not named as the routine DEFINER.
This access includes:
The contents of the Information Schema `ROUTINES` table.
The `SHOW CREATE FUNCTION` and `SHOW CREATE PROCEDURE` statements.
The `SHOW FUNCTION CODE` and `SHOW PROCEDURE CODE` statements.
The SHOW `FUNCTION STATUS` and `SHOW PROCEDURE STATUS` statements.
- `MDB_ADMIN`: Enables use of the KILL command, creating and dropping databases and users, granting privileges to tables and databases. ||
|| connectionLimits | **[ConnectionLimits](#yandex.cloud.mdb.mysql.v1.ConnectionLimits)**

Set of user connection limits. ||
|| authenticationPlugin | **enum** (AuthPlugin)

User authentication plugin.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| generatePassword | **boolean**

Generate password using Connection Manager. ||
|#

## Permission {#yandex.cloud.mdb.mysql.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **enum** (Privilege)

Roles granted to the user within the database.

See [the documentation](/docs/managed-mysql/operations/grant) for details.

- `PRIVILEGE_UNSPECIFIED`
- `ALL_PRIVILEGES`: All privileges that can be made available to the user.
- `ALTER`: Altering tables.
- `ALTER_ROUTINE`: Altering stored routines and functions.
- `CREATE`: Creating tables or indexes.
- `CREATE_ROUTINE`: Creating stored routines.
- `CREATE_TEMPORARY_TABLES`: Creating temporary tables.
- `CREATE_VIEW`: Creating views.
- `DELETE`: Deleting tables.
- `DROP`: Removing tables or views.
- `EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.
- `EXECUTE`: Executing stored routines.
- `INDEX`: Creating and removing indexes.
- `INSERT`: Inserting rows into the database.
- `LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.
- `SELECT`: Selecting rows from tables.

  Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege.

  See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.
- `SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.
- `TRIGGER`: Creating, removing, executing, or displaying triggers for a table.
- `UPDATE`: Updating rows in the database.
- `REFERENCES`: Creation of a foreign key constraint for the parent table. ||
|#

## ConnectionLimits {#yandex.cloud.mdb.mysql.v1.ConnectionLimits}

#|
||Field | Description ||
|| maxQuestionsPerHour | **string** (int64)

The maximum permitted number of user questions per hour. ||
|| maxUpdatesPerHour | **string** (int64)

The maximum permitted number of user updates per hour. ||
|| maxConnectionsPerHour | **string** (int64)

The maximum permitted number of simultaneous client connections per hour. ||
|| maxUserConnections | **string** (int64)

The maximum number of simultaneous connections permitted to any given MySQL user account. ||
|#

## HostSpec {#yandex.cloud.mdb.mysql.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.

To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet to assign to the host.

This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.networkId](#yandex.cloud.mdb.mysql.v1.CreateClusterRequest)). ||
|| assignPublicIp | **boolean**

Option that enables public IP address for the host so that the host can be accessed from the internet.

After a host has been created, this setting cannot be changed.
To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate `assignPublicIp` value set.

Possible values:
* `false` - don't assign a public IP address to the host.
* `true` - assign a public IP address to the host. ||
|| replicationSource | **string**

[Host.name](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) of the host to be used as the replication source (for cascading replication). ||
|| backupPriority | **string** (int64)

Host backup priority ||
|| priority | **string** (int64)

Host master promotion priority ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mysql.v1.MaintenanceWindow}

Configuration of a maintenance window in a MySQL cluster.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "environment": "string",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      // Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`
      "mysqlConfig_5_7": {
        "effectiveConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "generalLog": "boolean",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "defaultAuthenticationPlugin": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "showCompatibility_56": "boolean",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "binlogTransactionDependencyTracking": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "queryCacheLimit": "string",
          "queryCacheSize": "string",
          "queryCacheType": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "queryResponseTimeStats": "boolean",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "innodbLruScanDepth": "string",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        },
        "userConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "generalLog": "boolean",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "defaultAuthenticationPlugin": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "showCompatibility_56": "boolean",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "binlogTransactionDependencyTracking": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "queryCacheLimit": "string",
          "queryCacheSize": "string",
          "queryCacheType": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "queryResponseTimeStats": "boolean",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "innodbLruScanDepth": "string",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        },
        "defaultConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "generalLog": "boolean",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "defaultAuthenticationPlugin": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "showCompatibility_56": "boolean",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "binlogTransactionDependencyTracking": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "queryCacheLimit": "string",
          "queryCacheSize": "string",
          "queryCacheType": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "queryResponseTimeStats": "boolean",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "innodbLruScanDepth": "string",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        }
      },
      "mysqlConfig_8_0": {
        "effectiveConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "generalLog": "boolean",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "defaultAuthenticationPlugin": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "regexpTimeLimit": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "binlogTransactionDependencyTracking": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "replicationSenderObserveCommitOnly": "boolean",
          "replicationOptimizeForStaticPluginConfig": "boolean",
          "innodbLruScanDepth": "string",
          "sqlRequirePrimaryKey": "boolean",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        },
        "userConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "generalLog": "boolean",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "defaultAuthenticationPlugin": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "regexpTimeLimit": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "binlogTransactionDependencyTracking": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "replicationSenderObserveCommitOnly": "boolean",
          "replicationOptimizeForStaticPluginConfig": "boolean",
          "innodbLruScanDepth": "string",
          "sqlRequirePrimaryKey": "boolean",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        },
        "defaultConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "generalLog": "boolean",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "defaultAuthenticationPlugin": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "regexpTimeLimit": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "binlogTransactionDependencyTracking": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "replicationSenderObserveCommitOnly": "boolean",
          "replicationOptimizeForStaticPluginConfig": "boolean",
          "innodbLruScanDepth": "string",
          "sqlRequirePrimaryKey": "boolean",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        }
      },
      "mysqlConfig_8_4": {
        "effectiveConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "regexpTimeLimit": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "replicationSenderObserveCommitOnly": "boolean",
          "replicationOptimizeForStaticPluginConfig": "boolean",
          "innodbLruScanDepth": "string",
          "sqlRequirePrimaryKey": "boolean",
          "mdbUseAsyncReplication": "boolean",
          "mdbAsyncAllowedLag": "string",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        },
        "userConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "regexpTimeLimit": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "replicationSenderObserveCommitOnly": "boolean",
          "replicationOptimizeForStaticPluginConfig": "boolean",
          "innodbLruScanDepth": "string",
          "sqlRequirePrimaryKey": "boolean",
          "mdbUseAsyncReplication": "boolean",
          "mdbAsyncAllowedLag": "string",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        },
        "defaultConfig": {
          "innodbBufferPoolSize": "string",
          "maxConnections": "string",
          "longQueryTime": "number",
          "auditLog": "boolean",
          "sqlMode": [
            "string"
          ],
          "maxAllowedPacket": "string",
          "innodbFlushLogAtTrxCommit": "string",
          "innodbLockWaitTimeout": "string",
          "transactionIsolation": "string",
          "innodbPrintAllDeadlocks": "boolean",
          "netReadTimeout": "string",
          "netWriteTimeout": "string",
          "groupConcatMaxLen": "string",
          "tmpTableSize": "string",
          "maxHeapTableSize": "string",
          "defaultTimeZone": "string",
          "characterSetServer": "string",
          "collationServer": "string",
          "innodbAdaptiveHashIndex": "boolean",
          "innodbNumaInterleave": "boolean",
          "innodbLogBufferSize": "string",
          "innodbLogFileSize": "string",
          "innodbIoCapacity": "string",
          "innodbIoCapacityMax": "string",
          "innodbReadIoThreads": "string",
          "innodbWriteIoThreads": "string",
          "innodbPurgeThreads": "string",
          "innodbThreadConcurrency": "string",
          "innodbTempDataFileMaxSize": "string",
          "threadCacheSize": "string",
          "threadStack": "string",
          "joinBufferSize": "string",
          "sortBufferSize": "string",
          "tableDefinitionCache": "string",
          "tableOpenCache": "string",
          "tableOpenCacheInstances": "string",
          "explicitDefaultsForTimestamp": "boolean",
          "autoIncrementIncrement": "string",
          "autoIncrementOffset": "string",
          "syncBinlog": "string",
          "binlogCacheSize": "string",
          "binlogGroupCommitSyncDelay": "string",
          "binlogRowImage": "string",
          "binlogRowsQueryLogEvents": "boolean",
          "rplSemiSyncMasterWaitForSlaveCount": "string",
          "slaveParallelType": "string",
          "slaveParallelWorkers": "string",
          "regexpTimeLimit": "string",
          "mdbPreserveBinlogBytes": "string",
          "interactiveTimeout": "string",
          "waitTimeout": "string",
          "mdbOfflineModeEnableLag": "string",
          "mdbOfflineModeDisableLag": "string",
          "rangeOptimizerMaxMemSize": "string",
          "innodbOnlineAlterLogMaxSize": "string",
          "innodbFtMinTokenSize": "string",
          "innodbFtMaxTokenSize": "string",
          "lowerCaseTableNames": "string",
          "slowQueryLog": "boolean",
          "slowQueryLogAlwaysWriteTime": "number",
          "logSlowRateType": "string",
          "logSlowRateLimit": "string",
          "logSlowSpStatements": "boolean",
          "logSlowFilter": [
            "string"
          ],
          "mdbPriorityChoiceMaxLag": "string",
          "innodbPageSize": "string",
          "maxSpRecursionDepth": "string",
          "innodbCompressionLevel": "string",
          "autocommit": "boolean",
          "innodbStatusOutput": "boolean",
          "innodbStrictMode": "boolean",
          "innodbPrintLockWaitTimeoutInfo": "boolean",
          "logErrorVerbosity": "string",
          "maxDigestLength": "string",
          "lockWaitTimeout": "string",
          "maxPreparedStmtCount": "string",
          "optimizerSwitch": "string",
          "optimizerSearchDepth": "string",
          "userstat": "boolean",
          "maxExecutionTime": "string",
          "auditLogPolicy": "string",
          "replicationSenderObserveCommitOnly": "boolean",
          "replicationOptimizeForStaticPluginConfig": "boolean",
          "innodbLruScanDepth": "string",
          "sqlRequirePrimaryKey": "boolean",
          "mdbUseAsyncReplication": "boolean",
          "mdbAsyncAllowedLag": "string",
          "mdbForceSsl": "boolean",
          "innodbChangeBuffering": "string",
          "maxWriteLockCount": "string"
        }
      },
      // end of the list of possible fields
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
        "dataLens": "boolean",
        "webSql": "boolean",
        "dataTransfer": "boolean",
        "yandexQuery": "boolean"
      },
      "performanceDiagnostics": {
        "enabled": "boolean",
        "sessionsSamplingInterval": "string",
        "statementsSamplingInterval": "string"
      },
      "backupRetainPeriodDays": "string",
      "diskSizeAutoscaling": {
        "plannedUsageThreshold": "string",
        "emergencyUsageThreshold": "string",
        "diskSizeLimit": "string"
      }
    },
    "networkId": "string",
    "health": "string",
    "status": "string",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string"
    },
    "securityGroupIds": [
      "string"
    ],
    "deletionProtection": "boolean",
    "hostGroupIds": [
      "string"
    ],
    "diskEncryptionKeyId": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.mysql.v1.CreateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.mysql.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateClusterMetadata {#yandex.cloud.mdb.mysql.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.mdb.mysql.v1.Cluster}

An object that represents MySQL cluster.

See [the documentation](/docs/managed-mysql/concepts) for details.

#|
||Field | Description ||
|| id | **string**

ID of the cluster.

This ID is assigned by the platform at the time of creation. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp of the cluster.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the cluster. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the cluster as `key:value` pairs. ||
|| environment | **enum** (Environment)

Deployment environment of the MySQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Environment for stable versions of your apps.
A conservative update policy is in effect: only bug fixes are applied during regular maintenance.
- `PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself.
This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment.
However, not every update ensures backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.mysql.v1.Monitoring)**

Monitoring systems data that is relevant to the cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.mysql.v1.ClusterConfig)**

Configuration of the cluster. ||
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated health of the cluster.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `UNKNOWN`).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `ALIVE`).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for every host in the cluster is `DEAD`).
- `DEGRADED`: Cluster is degraded ([Host.health](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.Host) for at least one host in the cluster is not `ALIVE`). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.mysql.v1.MaintenanceWindow2)**

Maintenance window settings for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.mysql.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

Effective list of security group IDs applied to the cluster. ||
|| deletionProtection | **boolean**

This option prevents unintended deletion of the cluster. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## Monitoring {#yandex.cloud.mdb.mysql.v1.Monitoring}

Cluster-related monitoring system data.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.mysql.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of MySQL used in the cluster. ||
|| mysqlConfig_5_7 | **[MysqlConfigSet5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet5_7)**

Configuration of a MySQL 5.7 server.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.

Cluster-wide MySQL configuration. ||
|| mysqlConfig_8_0 | **[MysqlConfigSet8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_0)**

Configuration of a MySQL 8.0 server.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.

Cluster-wide MySQL configuration. ||
|| mysqlConfig_8_4 | **[MysqlConfigSet8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_4)**

Configuration of a MySQL 8.4 server.

Includes only one of the fields `mysqlConfig_5_7`, `mysqlConfig_8_0`, `mysqlConfig_8_4`.

Cluster-wide MySQL configuration. ||
|| resources | **[Resources](#yandex.cloud.mdb.mysql.v1.Resources2)**

Resource preset for the cluster hosts. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay2)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.mysql.v1.Access2)**

Access policy for external services. ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics2)**

Configuration of the performance diagnostics service. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling2)**

Disk size autoscaling ||
|#

## MysqlConfigSet5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet5_7}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_72)**

Effective settings for a MySQL 5.7 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_72)**

User-defined settings for a MySQL 5.7 cluster. ||
|| defaultConfig | **[MysqlConfig5_7](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_72)**

Default configuration for a MySQL 5.7 cluster. ||
|#

## MysqlConfig5_7 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig5_72}

Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file.

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **boolean**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting) for details.

- `SQLMODE_UNSPECIFIED`
- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `NO_FIELD_OPTIONS`
- `NO_KEY_OPTIONS`
- `NO_TABLE_OPTIONS`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `ANSI`
- `TRADITIONAL`
- `DB2`
- `MAXDB`
- `MSSQL`
- `MYSQL323`
- `MYSQL40`
- `ORACLE`
- `POSTGRESQL`
- `NO_AUTO_CREATE_USER`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/5.7/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_heap_table_size) for details. ||
|| defaultTimeZone | **string**

The servers default time zone.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_default-time-zone) for details. ||
|| characterSetServer | **string**

The servers default character set.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_character_set_server) for details. ||
|| collationServer | **string**

The server default collation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_collation_server) for details. ||
|| innodbAdaptiveHashIndex | **boolean**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **string** (int64)

A number of threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **boolean**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag value. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **boolean**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit`` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for `log_slow_rate_limit` values QUERY or SESSION.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size). ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size). ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size). ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lower_case_table_names). ||
|| showCompatibility_56 | **boolean**

Manages MySQL 5.6 compatibility

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_show_compatibility_56). ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_digest_length). ||
|| queryCacheLimit | **string** (int64)

Do not cache results that are larger than this number of bytes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_limit). ||
|| queryCacheSize | **string** (int64)

The amount of memory allocated for caching query results.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_size). ||
|| queryCacheType | **string** (int64)

Set the query cache type.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_query_cache_type). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html) ||
|| queryResponseTimeStats | **boolean**

Enables and disables collection of query times

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html#query_response_time_stats). ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/5.7/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_execution_time) ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

The policy controlling how the audit log plugin writes events to its log file

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/audit-log-reference.html#sysvar_audit_log_policy)

- `AUDIT_LOG_POLICY_UNSPECIFIED`
- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| innodbLruScanDepth | **string** (int64)

A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth) ||
|| mdbForceSsl | **boolean**

Force ssl on all hosts (require_secure_transport) ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

An optimization for change buffering

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

Permit some pending read lock requests interval
P.S. Should be UInt64, but java fails to handle UInt64 limits

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_write_lock_count). ||
|#

## MysqlConfigSet8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_0}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_02)**

Effective settings for a MySQL 8.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_02)**

User-defined settings for a MySQL 8.0 cluster. ||
|| defaultConfig | **[MysqlConfig8_0](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_02)**

Default configuration for a MySQL 8.0 cluster. ||
|#

## MysqlConfig8_0 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_02}

Options and structure of `MysqlConfig8_0` reflects MySQL 8.0 configuration file.

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) for details. ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections) for details. ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time) for details. ||
|| generalLog | **boolean**

Enable writing of general query log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log) for details. ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables) for details. ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) for details.

- `SQLMODE_UNSPECIFIED`
- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `TIME_TRUNCATE_FRACTIONAL`
- `ANSI`
- `TRADITIONAL`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

The maximum size in bytes of one packet.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) for details. ||
|| defaultAuthenticationPlugin | **enum** (AuthPlugin)

Authentication plugin used in the managed MySQL cluster.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin) for details.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Using [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Using [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Using [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) for details. ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) for details. ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation) for details.

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) for details. ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout) for details. ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout) for details. ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len) for details. ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size) for details. ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size) for details. ||
|| defaultTimeZone | **string**

The servers default time zone.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_default-time-zone) for details. ||
|| characterSetServer | **string**

The servers default character set.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_character_set_server) for details. ||
|| collationServer | **string**

The server default collation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_collation_server) for details. ||
|| innodbAdaptiveHashIndex | **boolean**

Enables InnoDB adaptive hash index.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) for details. ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave) for details. ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) for details. ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single InnoDB Redo log file.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) for details. ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity) for details. ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) for details. ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads) for details. ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads) for details. ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads) for details. ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) for details. ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) for details. ||
|| threadCacheSize | **string** (int64)

How many threads the server should cache for reuse.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size) for details. ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_thread_stack) for details. ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size) for details. ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size) for details. ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache) for details. ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache) for details. ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances) for details. ||
|| explicitDefaultsForTimestamp | **boolean**

Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp) for details. ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment) for details. ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset) for details. ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog) for details. ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size) for details. ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay) for details. ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) for details.

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events) for details. ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count) for details. ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type) for details.

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers) for details. ||
|| regexpTimeLimit | **string** (int64)

The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_regexp_time_limit) for details. ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout) for details. ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout) for details. ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size) for details. ||
|| slowQueryLog | **boolean**

Manages slow query log.

See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log) for details. ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, `log_slow_rate_limit` will not apply to it.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time) for details. ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for `log_slow_rate_limit` QUERY or SESSION value.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type) for details.

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit) for details. ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements) for details. ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan.

See [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter) for details.

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size) for details. ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size) for details. ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size) for details. ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

See [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names) for details. ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| binlogTransactionDependencyTracking | **enum** (BinlogTransactionDependencyTracking)

Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- `BINLOG_TRANSACTION_DEPENDENCY_TRACKING_UNSPECIFIED`
- `COMMIT_ORDER`
- `WRITESET`
- `WRITESET_SESSION` ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_optimizer_switch)
https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.0/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_execution_time) ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

The policy controlling how the audit log plugin writes events to its log file

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#sysvar_audit_log_policy)

- `AUDIT_LOG_POLICY_UNSPECIFIED`
- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| replicationSenderObserveCommitOnly | **boolean**

Limit callbacks to improve performance for semisynchronous replication

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only). ||
|| replicationOptimizeForStaticPluginConfig | **boolean**

Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config). ||
|| innodbLruScanDepth | **string** (int64)

A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth) ||
|| sqlRequirePrimaryKey | **boolean**

Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sql_require_primary_key). ||
|| mdbForceSsl | **boolean**

Force ssl on all hosts (require_secure_transport) ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

An optimization for change buffering

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

Permit some pending read lock requests interval
P.S. Should be UInt64, but java fails to handle UInt64 limits

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_write_lock_count). ||
|#

## MysqlConfigSet8_4 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfigSet8_4}

#|
||Field | Description ||
|| effectiveConfig | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_42)**

Effective settings for a MySQL 8.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_42)**

User-defined settings for a MySQL 8.4 cluster. ||
|| defaultConfig | **[MysqlConfig8_4](#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_42)**

Default configuration for a MySQL 8.4 cluster. ||
|#

## MysqlConfig8_4 {#yandex.cloud.mdb.mysql.v1.config.MysqlConfig8_42}

Options and structure of `MysqlConfig8_4` reflects MySQL 8.4 configuration file

#|
||Field | Description ||
|| innodbBufferPoolSize | **string** (int64)

Size of the InnoDB buffer pool used for caching table and index data.

For details, see [MySQL documentation for the parameter](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size). ||
|| maxConnections | **string** (int64)

The maximum permitted number of simultaneous client connections.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_connections). ||
|| longQueryTime | **number** (double)

Time that it takes to process a query before it is considered slow.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_long_query_time). ||
|| auditLog | **boolean**

Enable writing of audit log of MySQL.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/audit-log-reference.html#audit-log-options-variables). ||
|| sqlMode[] | **enum** (SQLMode)

Server SQL mode of MySQL.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/sql-mode.html#sql-mode-setting).

- `SQLMODE_UNSPECIFIED`
- `ALLOW_INVALID_DATES`
- `ANSI_QUOTES`
- `ERROR_FOR_DIVISION_BY_ZERO`
- `HIGH_NOT_PRECEDENCE`
- `IGNORE_SPACE`
- `NO_AUTO_VALUE_ON_ZERO`
- `NO_BACKSLASH_ESCAPES`
- `NO_ENGINE_SUBSTITUTION`
- `NO_UNSIGNED_SUBTRACTION`
- `NO_ZERO_DATE`
- `NO_ZERO_IN_DATE`
- `ONLY_FULL_GROUP_BY`
- `PAD_CHAR_TO_FULL_LENGTH`
- `PIPES_AS_CONCAT`
- `REAL_AS_FLOAT`
- `STRICT_ALL_TABLES`
- `STRICT_TRANS_TABLES`
- `TIME_TRUNCATE_FRACTIONAL`
- `ANSI`
- `TRADITIONAL`
- `NO_DIR_IN_CREATE` ||
|| maxAllowedPacket | **string** (int64)

The maximum size in bytes of one packet.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_allowed_packet). ||
|| innodbFlushLogAtTrxCommit | **string** (int64)

Transaction log flush behaviour.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit) ||
|| innodbLockWaitTimeout | **string** (int64)

Max time in seconds for a transaction to wait for a row lock

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout) ||
|| transactionIsolation | **enum** (TransactionIsolation)

Default transaction isolation level.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_transaction_isolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `READ_COMMITTED`
- `REPEATABLE_READ`
- `SERIALIZABLE` ||
|| innodbPrintAllDeadlocks | **boolean**

Print information about deadlocks in error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks) ||
|| netReadTimeout | **string** (int64)

The number of seconds to wait for more data from a connection before aborting the read.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_read_timeout) ||
|| netWriteTimeout | **string** (int64)

The number of seconds to wait for a block to be written to a connection before aborting the write.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_write_timeout) ||
|| groupConcatMaxLen | **string** (int64)

The maximum permitted result length in bytes for the GROUP_CONCAT() function.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_group_concat_max_len) ||
|| tmpTableSize | **string** (int64)

The maximum size of internal in-memory temporary tables.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_tmp_table_size) ||
|| maxHeapTableSize | **string** (int64)

This variable sets the maximum size to which user-created MEMORY tables are permitted to grow.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_heap_table_size) ||
|| defaultTimeZone | **string**

The servers default time zone.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-options.html#option_mysqld_default-time-zone) ||
|| characterSetServer | **string**

The servers default character set.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_character_set_server) ||
|| collationServer | **string**

Set the default server collation.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_collation_server) ||
|| innodbAdaptiveHashIndex | **boolean**

Enables Innodb adaptive hash index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index) ||
|| innodbNumaInterleave | **boolean**

Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_numa_interleave) ||
|| innodbLogBufferSize | **string** (int64)

The size in bytes of the buffer that InnoDB uses to write to the log files on disk.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_log_buffer_size) ||
|| innodbLogFileSize | **string** (int64)

The size in bytes of the single Innodb Redo log file.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_log_file_size) ||
|| innodbIoCapacity | **string** (int64)

Limits IO available for InnoDB background tasks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_io_capacity) ||
|| innodbIoCapacityMax | **string** (int64)

Limits IO available for InnoDB background tasks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_io_capacity_max) ||
|| innodbReadIoThreads | **string** (int64)

The number of I/O threads for read operations in InnoDB.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_read_io_threads) ||
|| innodbWriteIoThreads | **string** (int64)

The number of I/O threads for write operations in InnoDB.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_write_io_threads) ||
|| innodbPurgeThreads | **string** (int64)

The number of background threads devoted to the InnoDB purge operation.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_purge_threads) ||
|| innodbThreadConcurrency | **string** (int64)

Defines the maximum number of threads permitted inside of InnoDB.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_thread_concurrency) ||
|| innodbTempDataFileMaxSize | **string** (int64)

Limits the max size of InnoDB temp tablespace

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path) ||
|| threadCacheSize | **string** (int64)

How many threads the server should cache for reuse.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_thread_cache_size). ||
|| threadStack | **string** (int64)

The stack size for each thread. The default is large enough for normal operation.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_thread_stack). ||
|| joinBufferSize | **string** (int64)

The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_join_buffer_size). ||
|| sortBufferSize | **string** (int64)

Each session that must perform a sort allocates a buffer of this size.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_sort_buffer_size). ||
|| tableDefinitionCache | **string** (int64)

The number of table definitions that can be stored in the definition cache.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_definition_cache). ||
|| tableOpenCache | **string** (int64)

The number of open tables for all threads.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_open_cache). ||
|| tableOpenCacheInstances | **string** (int64)

The number of open tables cache instances.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_table_open_cache_instances). ||
|| explicitDefaultsForTimestamp | **boolean**

This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp). ||
|| autoIncrementIncrement | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_auto_increment_increment). ||
|| autoIncrementOffset | **string** (int64)

Can be used to control the operation of AUTO_INCREMENT columns.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_auto_increment_offset). ||
|| syncBinlog | **string** (int64)

Controls how often the MySQL server synchronizes the binary log to disk.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_sync_binlog). ||
|| binlogCacheSize | **string** (int64)

The size of the cache to hold changes to the binary log during a transaction.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_cache_size). ||
|| binlogGroupCommitSyncDelay | **string** (int64)

Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay). ||
|| binlogRowImage | **enum** (BinlogRowImage)

For MySQL row-based replication, this variable determines how row images are written to the binary log.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_row_image).

- `BINLOG_ROW_IMAGE_UNSPECIFIED`
- `FULL`
- `MINIMAL`
- `NOBLOB` ||
|| binlogRowsQueryLogEvents | **boolean**

When enabled, it causes the server to write informational log events such as row query log events into its binary log.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events). ||
|| rplSemiSyncMasterWaitForSlaveCount | **string** (int64)

The number of replica acknowledgments the source must receive per transaction before proceeding.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-master.html#sysvar_rpl_semi_sync_master_wait_for_slave_count). ||
|| slaveParallelType | **enum** (SlaveParallelType)

When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_slave_parallel_type).

- `SLAVE_PARALLEL_TYPE_UNSPECIFIED`
- `DATABASE`
- `LOGICAL_CLOCK` ||
|| slaveParallelWorkers | **string** (int64)

Sets the number of applier threads for executing replication transactions in parallel.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_slave_parallel_workers). ||
|| regexpTimeLimit | **string** (int64)

The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_regexp_time_limit). ||
|| mdbPreserveBinlogBytes | **string** (int64)

The size of the binary log to hold. ||
|| interactiveTimeout | **string** (int64)

The number of seconds the server waits for activity on an interactive connection before closing it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_interactive_timeout). ||
|| waitTimeout | **string** (int64)

The number of seconds the server waits for activity on a noninteractive connection before closing it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_wait_timeout). ||
|| mdbOfflineModeEnableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data. ||
|| mdbOfflineModeDisableLag | **string** (int64)

Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'.
Should be less than mdb_offline_mode_enable_lag. ||
|| rangeOptimizerMaxMemSize | **string** (int64)

The limit on memory consumption for the range optimizer.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size). ||
|| innodbOnlineAlterLogMaxSize | **string** (int64)

The limit in bytes on the size of the temporary log files used during online DDL operations

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size). ||
|| innodbFtMinTokenSize | **string** (int64)

Minimum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size). ||
|| innodbFtMaxTokenSize | **string** (int64)

Maximum length of words that are stored in an InnoDB FULLTEXT index

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size). ||
|| lowerCaseTableNames | **string** (int64)

Table names storage and comparison strategy

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_lower_case_table_names). ||
|| slowQueryLog | **boolean**

Manages slow query log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_slow_query_log). ||
|| slowQueryLogAlwaysWriteTime | **number** (double)

Query execution time, after which query to be logged unconditionally, that is, log_slow_rate_limit will not apply to it

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#slow_query_log_always_write_time). ||
|| logSlowRateType | **enum** (LogSlowRateType)

Specifies slow log granularity for log_slow_rate_limit: QUERY or SESSION

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_rate_type).

- `LOG_SLOW_RATE_TYPE_UNSPECIFIED`
- `SESSION`
- `QUERY` ||
|| logSlowRateLimit | **string** (int64)

Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query.

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_rate_limit). ||
|| logSlowSpStatements | **boolean**

When TRUE, statements executed by stored procedures are logged to the slow log

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_sp_statements). ||
|| logSlowFilter[] | **enum** (LogSlowFilterType)

Filters the slow log by the query's execution plan

For details, see [Percona documentation for the variable](https://www.percona.com/doc/percona-server/8.4/diagnostics/slow_extended.html#log_slow_filter).

- `LOG_SLOW_FILTER_TYPE_UNSPECIFIED`
- `FULL_SCAN`
- `FULL_JOIN`
- `TMP_TABLE`
- `TMP_TABLE_ON_DISK`
- `FILESORT`
- `FILESORT_ON_DISK` ||
|| mdbPriorityChoiceMaxLag | **string** (int64)

Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from".
Should be less than mdb_offline_mode_disable_lag. ||
|| innodbPageSize | **string** (int64)

Specifies the page size for InnoDB tablespaces.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_page_size). ||
|| maxSpRecursionDepth | **string** (int64)

The number of times that any given stored procedure may be called recursively.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_sp_recursion_depth). ||
|| innodbCompressionLevel | **string** (int64)

The level of zlib compression to use for InnoDB compressed tables and indexes.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_compression_level). ||
|| autocommit | **boolean**

Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_autocommit). ||
|| innodbStatusOutput | **boolean**

Enables or disables periodic output for the standard InnoDB Monitor.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_status_output). ||
|| innodbStrictMode | **boolean**

When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_strict_mode). ||
|| innodbPrintLockWaitTimeoutInfo | **boolean**

Makes InnoDB to write information about all lock wait timeout errors into the log file.

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.4/diagnostics/innodb_show_status.html?highlight=innodb_print_lock_wait_timeout_info). ||
|| logErrorVerbosity | **string** (int64)

System variable specifies the verbosity for handling events intended for the error log

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_log_error_verbosity). ||
|| maxDigestLength | **string** (int64)

The maximum number of bytes of memory reserved per session for computation of normalized statement digests.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_digest_length). ||
|| lockWaitTimeout | **string** (int64)

This variable specifies the timeout in seconds for attempts to acquire metadata locks

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_lock_wait_timeout). ||
|| maxPreparedStmtCount | **string** (int64)

This variable limits the total number of prepared statements in the server.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_prepared_stmt_count). ||
|| optimizerSwitch | **string**

The system variable enables control over optimizer behavior.

For details, see [MySQL documentation for the variable]
https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_optimizer_switch
https://dev.mysql.com/doc/refman/8.4/en/switchable-optimizations.html ||
|| optimizerSearchDepth | **string** (int64)

The maximum depth of search performed by the query optimizer

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html) ||
|| userstat | **boolean**

Enables or disables collection of statistics

For details, see [Percona documentation for the variable](https://docs.percona.com/percona-server/8.4/diagnostics/user_stats.html#userstat). ||
|| maxExecutionTime | **string** (int64)

The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled.

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_execution_time) ||
|| auditLogPolicy | **enum** (AuditLogPolicy)

The policy controlling how the audit log plugin writes events to its log file

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/audit-log-reference.html#sysvar_audit_log_policy)

- `AUDIT_LOG_POLICY_UNSPECIFIED`
- `ALL`
- `LOGINS`
- `QUERIES`
- `NONE` ||
|| replicationSenderObserveCommitOnly | **boolean**

Limit callbacks to improve performance for semisynchronous replication

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only). ||
|| replicationOptimizeForStaticPluginConfig | **boolean**

Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config). ||
|| innodbLruScanDepth | **string** (int64)

A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool

For details, see [MySQL documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth) ||
|| sqlRequirePrimaryKey | **boolean**

Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_sql_require_primary_key). ||
|| mdbUseAsyncReplication | **boolean**

Enable async replication ||
|| mdbAsyncAllowedLag | **string** (int64)

Async replication allowed lag (seconds) ||
|| mdbForceSsl | **boolean**

Force ssl on all hosts (require_secure_transport) ||
|| innodbChangeBuffering | **enum** (InnodbChangeBuffering)

An optimization for change buffering

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- `INNODB_CHANGE_BUFFERING_UNSPECIFIED`
- `INNODB_CHANGE_BUFFERING_NONE`
- `INNODB_CHANGE_BUFFERING_INSERTS`
- `INNODB_CHANGE_BUFFERING_DELETES`
- `INNODB_CHANGE_BUFFERING_CHANGES`
- `INNODB_CHANGE_BUFFERING_PURGES`
- `INNODB_CHANGE_BUFFERING_ALL` ||
|| maxWriteLockCount | **string** (int64)

Permit some pending read lock requests interval
P.S. Should be UInt64, but java fails to handle UInt64 limits

For details, see [Percona documentation for the variable](https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_max_write_lock_count). ||
|#

## Resources {#yandex.cloud.mdb.mysql.v1.Resources2}

Cluster resource preset.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.

All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage (for each cluster host, in bytes). ||
|| diskTypeId | **string**

Type of the storage.

Possible values:
* `network-hdd` - standard network storage
* `network-ssd` - fast network storage
* `network-ssd-nonreplicated` - fast network nonreplicated storage
* `local-ssd` - fast local storage.

See [the documentation](/docs/managed-mysql/concepts/storage) for details. ||
|#

## TimeOfDay {#google.type.TimeOfDay2}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.mysql.v1.Access2}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows access from DataLens.

See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from management console.

See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.mysql.v1.PerformanceDiagnostics2}

#|
||Field | Description ||
|| enabled | **boolean**

Flag that shows if performance statistics gathering is enabled for the cluster. ||
|| sessionsSamplingInterval | **string** (int64)

Interval (in seconds) for `my_session` sampling. ||
|| statementsSamplingInterval | **string** (int64)

Interval (in seconds) for `my_statements` sampling. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mysql.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mysql.v1.MaintenanceWindow2}

Configuration of a maintenance window in a MySQL cluster.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow2)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mysql.v1.WeeklyMaintenanceWindow2}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.mysql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#