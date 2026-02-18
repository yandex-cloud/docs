---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-greenplum/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the Greenplum® cluster in.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the Greenplum® cluster. The name must be unique within the folder.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the Greenplum® cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Greenplum® cluster as `key:value` pairs.
            For example, `"project":"mvp"` or `"source":"dictionary"`.
            No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
          maxProperties: 64
        environment:
          description: |-
            **enum** (Environment)
            Required field. Deployment environment of the Greenplum® cluster.
            - `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
            - `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.
          type: string
          enum:
            - ENVIRONMENT_UNSPECIFIED
            - PRODUCTION
            - PRESTABLE
        config:
          description: |-
            **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig)**
            Greenplum® cluster configuration.
          $ref: '#/definitions/GreenplumConfig'
        masterConfig:
          description: |-
            **[MasterSubclusterConfigSpec](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfigSpec)**
            Configuration of the Greenplum® master subcluster.
          $ref: '#/definitions/MasterSubclusterConfigSpec'
        segmentConfig:
          description: |-
            **[SegmentSubclusterConfigSpec](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfigSpec)**
            Configuration of the Greenplum® segment subcluster.
          $ref: '#/definitions/SegmentSubclusterConfigSpec'
        masterHostCount:
          description: |-
            **string** (int64)
            Number of hosts in the master subcluster.
          type: string
          format: int64
        segmentInHost:
          description: |-
            **string** (int64)
            Number of segments per host.
          type: string
          format: int64
        segmentHostCount:
          description: |-
            **string** (int64)
            Number of hosts in the segment subcluster.
          type: string
          format: int64
        userName:
          description: |-
            **string**
            Required field. Owner user name.
          type: string
        userPassword:
          description: |-
            **string**
            Required field. Owner user password.
            The string length in characters must be 8-128.
          type: string
        networkId:
          description: |-
            **string**
            Required field. ID of the network to create the cluster in.
            The maximum string length in characters is 50.
          type: string
        securityGroupIds:
          description: |-
            **string**
            User security groups.
          type: array
          items:
            type: string
        deletionProtection:
          description: |-
            **boolean**
            Determines whether the cluster is protected from being deleted.
          type: boolean
        hostGroupIds:
          description: |-
            **string**
            Host groups to place VMs of the cluster in.
          type: array
          items:
            type: string
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**
            A Greenplum® cluster maintenance window. Should be defined by either one of the two options.
          $ref: '#/definitions/MaintenanceWindow'
        configSpec:
          description: |-
            **[ConfigSpec](#yandex.cloud.mdb.greenplum.v1.ConfigSpec)**
            Configuration of Greenplum® and Odyssey®.
          $ref: '#/definitions/ConfigSpec'
        cloudStorage:
          description: |-
            **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage)**
            Cloud storage settings
          $ref: '#/definitions/CloudStorage'
        masterHostGroupIds:
          description: |-
            **string**
            Host groups hosting VMs of the master subcluster.
          type: array
          items:
            type: string
        segmentHostGroupIds:
          description: |-
            **string**
            Host groups hosting VMs of the segment subcluster.
          type: array
          items:
            type: string
        serviceAccountId:
          description: |-
            **string**
            ID of the service account used for access Yandex Cloud resources.
          type: string
        logging:
          description: |-
            **[LoggingConfig](#yandex.cloud.mdb.greenplum.v1.LoggingConfig)**
            Cloud logging configuration
          $ref: '#/definitions/LoggingConfig'
      required:
        - folderId
        - name
        - environment
        - userName
        - userPassword
        - networkId
      additionalProperties: false
    definitions:
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
              Allows data export from the cluster to DataLens.
            type: boolean
          webSql:
            description: |-
              **boolean**
              Allows SQL queries to the cluster databases from the management console.
            type: boolean
          dataTransfer:
            description: |-
              **boolean**
              Allows access for DataTransfer.
            type: boolean
          yandexQuery:
            description: |-
              **boolean**
              Allow access for YandexQuery.
            type: boolean
      GreenplumConfig:
        type: object
        properties:
          version:
            description: |-
              **string**
              Version of the Greenplum® server software.
            type: string
          backupWindowStart:
            description: |-
              **[TimeOfDay](#google.type.TimeOfDay)**
              Time to start the daily backup, in the UTC timezone.
            $ref: '#/definitions/TimeOfDay'
          backupRetainPeriodDays:
            description: |-
              **string** (int64)
              Retention policy of automated backups.
              Acceptable values are 1 to 60, inclusive.
            type: string
            format: int64
          access:
            description: |-
              **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**
              Access policy for external services.
            $ref: '#/definitions/Access'
          zoneId:
            description: |-
              **string**
              ID of the availability zone the cluster belongs to.
              To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
              The maximum string length in characters is 50.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.networkId](#yandex.cloud.mdb.greenplum.v1.Cluster)).
              The maximum string length in characters is 50.
            type: string
          assignPublicIp:
            description: |-
              **boolean**
              Determines whether the cluster has a public IP address.
              After the cluster has been created, this setting cannot be changed.
            type: boolean
          fullVersion:
            description: |-
              **string**
              Full version
            type: string
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the preset for computational resources allocated to a host.
              Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types).
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage used by the host, in bytes.
            type: string
            format: int64
          diskTypeId:
            description: |-
              **string**
              Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`.
            type: string
      MasterSubclusterConfigSpec:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**
              Resources allocated to Greenplum® master subcluster hosts.
            $ref: '#/definitions/Resources'
      SegmentSubclusterConfigSpec:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**
              Resources allocated to Greenplum® segment subcluster hosts.
            $ref: '#/definitions/Resources'
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week.
              - `MON`: Monday
              - `TUE`: Tuesday
              - `WED`: Wednesday
              - `THU`: Thursday
              - `FRI`: Friday
              - `SAT`: Saturday
              - `SUN`: Sunday
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
              Hour of the day in the UTC timezone.
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              An any-time maintenance window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**
              A weekly maintenance window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
      GreenplumConfig6:
        type: object
        properties:
          maxConnections:
            description: |-
              **string** (int64)
              Maximum number of inbound connections on master segment
              Acceptable values are 50 to 1000, inclusive.
            type: string
            format: int64
          maxSlotWalKeepSize:
            description: |-
              **string** (int64)
              Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
              https://www.postgresql.org/docs/current/runtime-config-replication.html
              Acceptable values are 0 to 214748364800, inclusive.
            type: string
            format: int64
          gpWorkfileLimitPerSegment:
            description: |-
              **string** (int64)
              Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
              The default value is 0, which means a limit is not enforced.
              https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment
              The minimum value is 0.
            type: string
            format: int64
          gpWorkfileLimitPerQuery:
            description: |-
              **string** (int64)
              Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
              The default value is 0, which means a limit is not enforced.
              https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query
              Acceptable values are 0 to 1099511627776, inclusive.
            type: string
            format: int64
          gpWorkfileLimitFilesPerQuery:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
              Spill files are created when executing a query that requires more memory than it is allocated.
              The current query is terminated when the limit is exceeded.
              Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
              https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
              Default value is 10000
              Acceptable values are 0 to 100000, inclusive.
            type: string
            format: int64
          maxPreparedTransactions:
            description: |-
              **string** (int64)
              Sets the maximum number of transactions that can be in the "prepared" state simultaneously
              https://www.postgresql.org/docs/9.6/runtime-config-resource.html
              Acceptable values are 50 to 10000, inclusive.
            type: string
            format: int64
          gpWorkfileCompression:
            description: |-
              **boolean**
              Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
              https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression
            type: boolean
          maxStatementMem:
            description: |-
              **string** (int64)
              Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
              Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
              (seghost_physical_memory) / (average_number_concurrent_queries)
              When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
              https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
              Default value is 2097152000 (2000MB)
              Acceptable values are 134217728 to 1099511627776, inclusive.
            type: string
            format: int64
          logStatement:
            description: |-
              **enum** (LogStatement)
              Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
              MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
              PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
              https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
              Default value is ddl
              - `NONE`: None statements are logged.
              - `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
              - `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
              - `ALL`: Logs all statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - NONE
              - DDL
              - MOD
              - ALL
          gpAddColumnInheritsTableSetting:
            description: |-
              **boolean**
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting
            type: boolean
          gpEnableGlobalDeadlockDetector:
            description: |-
              **boolean**
              Controls whether the Greenplum Database Global Deadlock Detector is enabled to manage concurrent UPDATE and DELETE operations on heap tables to improve performance. See Inserting, Updating, and Deleting Datain the Greenplum Database Administrator Guide. The default is off, the Global Deadlock Detector is deactivated.
              If the Global Deadlock Detector is deactivated (the default), Greenplum Database runs concurrent update and delete operations on a heap table serially.
              If the Global Deadlock Detector is enabled, concurrent updates are permitted and the Global Deadlock Detector determines when a deadlock exists, and breaks the deadlock by cancelling one or more backend processes associated with the youngest transaction(s) involved.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector
            type: boolean
          gpGlobalDeadlockDetectorPeriod:
            description: |-
              **string** (int64)
              Specifies the executing interval (in seconds) of the global deadlock detector background worker process.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period
            type: string
            format: int64
          gpMaxSlices:
            description: |-
              **string** (int64)
              Max amount of slice-processes for one query in one segment.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_slices
              Acceptable values are 10 to 100, inclusive.
            type: string
            format: int64
          gpCachedSegworkersThreshold:
            description: |-
              **string** (int64)
              Define amount of working processes in segment, that keeping in warm cash after end of query for usage again in next queries.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_cached_segworkers_threshold
              Acceptable values are 0 to 10, inclusive.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Max time (in ms) which query will wait lock free on object
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#lock_timeout
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Max time (in ms) which session can idle in open transaction
              https://postgrespro.ru/docs/postgrespro/current/runtime-config-client#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          runawayDetectorActivationPercent:
            description: |-
              **string** (int64)
              Percent of utilized Greenplum Database vmem that triggers the termination of queries.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#runaway_detector_activation_percent
              Acceptable values are 0 to 100, inclusive.
            type: string
            format: int64
          gpVmemProtectSegworkerCacheLimit:
            description: |-
              **string** (int64)
              Set memory limit (in MB) for working process. If a query executor process consumes more than this configured amount, then the process will not be cached for use in subsequent queries after the process completes.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_vmem_protect_segworker_cache_limit
              Acceptable values are 0 to 4096, inclusive.
            type: string
            format: int64
          gpEnableZstdMemoryAccounting:
            description: |-
              **boolean**
              Forces ZSTD lib use Greenplum memory allocation system.
            type: boolean
          gpMaxPlanSize:
            description: |-
              **string** (int64)
              Specifies the total maximum uncompressed size of a query execution plan multiplied by the number of Motion operators (slices) in the plan.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_plan_size
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          gpAutostatsMode:
            description: |-
              **enum** (GPAutostatsMode)
              Specifies the mode for triggering automatic statistics collection after DML.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_mode
              - `GP_AUTOSTATS_MODE_NONE`: Disable auto-ANALYZE completely. Stats will be updated only via manual ANALYZE calls.
              - `GP_AUTOSTATS_MODE_ON_CHANGE`: Run ANALYZE when data changes exceed threshold (e.g., after INSERT/UPDATE/DELETE).
              - `GP_AUTOSTATS_MODE_ON_NO_STATS`: Run ANALYZE only if no stats exist (e.g., new or cleared table).
            type: string
            enum:
              - GP_AUTOSTATS_MODE_UNSPECIFIED
              - GP_AUTOSTATS_MODE_NONE
              - GP_AUTOSTATS_MODE_ON_CHANGE
              - GP_AUTOSTATS_MODE_ON_NO_STATS
          gpAutostatsOnChangeThreshold:
            description: |-
              **string** (int64)
              Specifies the threshold for automatic statistics collection when gp_autostats_mode is set to on_change.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_on_change_threshold
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          gpResourceGroupMemoryLimit:
            description: |-
              **number** (double)
              Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum Database segment node.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_group_memory_limit
            type: number
            format: double
          logConnections:
            description: |-
              **boolean**
              This outputs a line to the server log detailing each successful connection. Some client programs, like psql,
              attempt to connect twice while determining if a password is required, so duplicate "connection received" messages
              do not always indicate a problem.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_connections
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              This outputs a line in the server log at termination of a client session, and includes the duration of the session.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections
            type: boolean
          logHostname:
            description: |-
              **boolean**
              By default, connection log messages only show the IP address of the connecting host.
              Turning on this option causes logging of the host name as well. Note that depending on your host name
              resolution setup this might impose a non-negligible performance penalty.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname
            type: boolean
          logStatementStats:
            description: |-
              **boolean**
              For each query, write total performance statistics of the query parser, planner, and executor to the server log.
              This is a crude profiling instrument.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats
            type: boolean
          logMinDurationStatement:
            description: |-
              **string** (int64)
              Logs the statement and its duration on a single log line if its duration is greater than or equal
              to the specified number of milliseconds. Setting this to 0 will print all statements and their durations.
              -1 deactivates the feature. For example, if you set it to 250 then all SQL statements that run 250ms or longer will be logged.
              Enabling this option can be useful in tracking down unoptimized queries in your applications.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement
            type: string
            format: int64
          masterSharedBuffers:
            description: |-
              **string** (int64)
              Sets the amount of memory a Greenplum Database master instance uses for shared memory buffers.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers
              Acceptable values are 1048576 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              The shared lock table is created with room to describe locks on max_locks_per_transaction * (max_connections + max_prepared_transactions) objects,
              so no more than this many distinct objects can be locked at any one time.
              This is not a hard limit on the number of locks taken by any one transaction, but rather a maximum average value.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#max_locks_per_transaction
              Acceptable values are 128 to 2048, inclusive.
            type: string
            format: int64
          segmentSharedBuffers:
            description: |-
              **string** (int64)
              Sets the amount of memory a Greenplum Database segment instance uses for shared memory buffers.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers
              Acceptable values are 1048576 to 2147483647, inclusive.
            type: string
            format: int64
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Controls the amount of detail written in the server log for each message that is logged.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity
              - `TERSE`
              - `DEFAULT`
              - `VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - TERSE
              - DEFAULT
              - VERBOSE
          logMinMessages:
            description: |-
              **enum** (LogLevelMessage)
              Controls which message levels are written to the server log.
              Each level includes all the levels that follow it. The later the level, the fewer messages are sent to the log.
              https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages
              - `DEBUG5`
              - `DEBUG4`
              - `DEBUG3`
              - `DEBUG2`
              - `DEBUG1`
              - `INFO`
              - `NOTICE`
              - `WARNING`
              - `ERROR`
              - `FATAL`
              - `PANIC`
            type: string
            enum:
              - LOG_LEVEL_MESSAGE_UNSPECIFIED
              - DEBUG5
              - DEBUG4
              - DEBUG3
              - DEBUG2
              - DEBUG1
              - INFO
              - NOTICE
              - WARNING
              - ERROR
              - FATAL
              - PANIC
      ConnectionPoolerConfig:
        type: object
        properties:
          mode:
            description: |-
              **enum** (PoolMode)
              Route server pool mode.
              - `SESSION`: Assign server connection to a client until it disconnects. Default value.
              - `TRANSACTION`: Assign server connection to a client for a transaction processing.
            type: string
            enum:
              - POOL_MODE_UNSPECIFIED
              - SESSION
              - TRANSACTION
          size:
            description: |-
              **string** (int64)
              The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.
              Set to zero to disable the limit.
            type: string
            format: int64
          clientIdleTimeout:
            description: |-
              **string** (int64)
              Client pool idle timeout, in seconds.
              Drop stale client connection after this much seconds of idleness, which is not in transaction.
              Set to zero to disable.
            type: string
            format: int64
          idleInTransactionTimeout:
            description: |-
              **string** (int64)
              Client pool idle in transaction timeout, in seconds.
              Drop client connection in transaction after this much seconds of idleness.
              Set to zero to disable.
            type: string
            format: int64
      BackgroundActivityStartAt:
        type: object
        properties:
          hours:
            description: |-
              **string** (int64)
              hours
              Acceptable values are 0 to 23, inclusive.
            type: string
            format: int64
          minutes:
            description: |-
              **string** (int64)
              minutes
              Acceptable values are 0 to 59, inclusive.
            type: string
            format: int64
      TableSizes:
        type: object
        properties:
          starts:
            description: |-
              **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)**
              Time when start "table_sizes" script
              The maximum number of elements is 4.
            type: array
            items:
              $ref: '#/definitions/BackgroundActivityStartAt'
      AnalyzeAndVacuum:
        type: object
        properties:
          start:
            description: |-
              **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)**
              Time when analyze will start
            $ref: '#/definitions/BackgroundActivityStartAt'
          analyzeTimeout:
            description: |-
              **string** (int64)
              Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.
              Acceptable values are 7200 to 86399, inclusive.
            type: string
            format: int64
          vacuumTimeout:
            description: |-
              **string** (int64)
              Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.
              Acceptable values are 7200 to 86399, inclusive.
            type: string
            format: int64
      QueryKiller:
        type: object
        properties:
          enable:
            description: |-
              **boolean**
              Use query killer or not
            type: boolean
          maxAge:
            description: |-
              **string** (int64)
              Maximum duration for this type of queries (in seconds).
              Acceptable values are 1 to 86400, inclusive.
            type: string
            format: int64
          ignoreUsers:
            description: |-
              **string**
              Ignore these users when considering queries to terminate
            type: array
            items:
              type: string
      QueryKillerScripts:
        type: object
        properties:
          idle:
            description: |-
              **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**
              Configuration of script that kills long running queries that are in `idle` state.
            $ref: '#/definitions/QueryKiller'
          idleInTransaction:
            description: |-
              **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**
              Configuration of script that kills long running queries that are in `idle in transaction` state.
            $ref: '#/definitions/QueryKiller'
          longRunning:
            description: |-
              **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**
              Configuration of script that kills long running queries (in any state).
            $ref: '#/definitions/QueryKiller'
      BackgroundActivitiesConfig:
        type: object
        properties:
          tableSizes:
            description: |-
              **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes)**
              Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema.
            $ref: '#/definitions/TableSizes'
          analyzeAndVacuum:
            description: |-
              **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum)**
              Configuration for `ANALYZE` and `VACUUM` operations.
            $ref: '#/definitions/AnalyzeAndVacuum'
          queryKillerScripts:
            description: |-
              **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts)**
              Configuration for long running queries killer.
            $ref: '#/definitions/QueryKillerScripts'
      PXFConfig:
        type: object
        properties:
          connectionTimeout:
            description: |-
              **string** (int64)
              Timeout for connection to the Apache Tomcat® server when making read requests.
              Specify values in seconds.
              Acceptable values are 5 to 600, inclusive.
            type: string
            format: int64
          uploadTimeout:
            description: |-
              **string** (int64)
              Timeout for connection to the Apache Tomcat® server when making write requests.
              Specify the values in seconds.
              Acceptable values are 5 to 600, inclusive.
            type: string
            format: int64
          maxThreads:
            description: |-
              **string** (int64)
              Maximum number of the Apache Tomcat® threads.
              To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-9/gp-pxf/cfg_mem.html) documentation.
              Acceptable values are 1 to 1024, inclusive.
            type: string
            format: int64
          poolAllowCoreThreadTimeout:
            description: |-
              **boolean**
              Determines whether the timeout for core streaming threads is permitted.
            type: boolean
          poolCoreSize:
            description: |-
              **string** (int64)
              Number of core streaming threads per pool.
              Acceptable values are 1 to 1024, inclusive.
            type: string
            format: int64
          poolQueueCapacity:
            description: |-
              **string** (int64)
              Maximum number of requests you can add to a pool queue for core streaming threads.
              If `0`, no pool queue is generated.
              The minimum value is 0.
            type: string
            format: int64
          poolMaxSize:
            description: |-
              **string** (int64)
              Maximum allowed number of core streaming threads.
              Acceptable values are 1 to 1024, inclusive.
            type: string
            format: int64
          xmx:
            description: |-
              **string** (int64)
              Initial size, in megabytes, of the JVM heap for the PXF daemon.
              The minimum value is 64.
            type: string
            format: int64
          xms:
            description: |-
              **string** (int64)
              Maximum size, in megabytes, of the JVM heap for the PXF daemon.
              The minimum value is 64.
            type: string
            format: int64
      ConfigSpec:
        type: object
        properties:
          greenplumConfig_6:
            description: |-
              **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**
              Includes only one of the fields `greenplumConfig_6`.
            $ref: '#/definitions/GreenplumConfig6'
          pool:
            description: |-
              **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**
              Odyssey® pool settings.
            $ref: '#/definitions/ConnectionPoolerConfig'
          backgroundActivities:
            description: |-
              **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig)**
              Managed Greenplum® background tasks configuration.
            $ref: '#/definitions/BackgroundActivitiesConfig'
          pxfConfig:
            description: '**[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**'
            $ref: '#/definitions/PXFConfig'
        oneOf:
          - required:
              - greenplumConfig_6
      CloudStorage:
        type: object
        properties:
          enable:
            description: |-
              **boolean**
              enable Cloud Storage for cluster
            type: boolean
      LoggingConfig:
        type: object
        properties:
          enabled:
            description: '**boolean**'
            type: boolean
          folderId:
            description: |-
              **string**
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          logGroupId:
            description: |-
              **string**
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          commandCenterEnabled:
            description: |-
              **boolean**
              send Yandex Command Center logs
            type: boolean
          greenplumEnabled:
            description: |-
              **boolean**
              send Greenplum logs
            type: boolean
          poolerEnabled:
            description: |-
              **boolean**
              send Pooler logs
            type: boolean
        oneOf:
          - required:
              - folderId
          - required:
              - logGroupId
---

# Managed Service for Greenplum® API, REST: Cluster.Create

Creates a Greenplum® cluster in the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-greenplum/v1/clusters
```

## Body parameters {#yandex.cloud.mdb.greenplum.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "config": {
    "version": "string",
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "backupRetainPeriodDays": "string",
    "access": {
      "dataLens": "boolean",
      "webSql": "boolean",
      "dataTransfer": "boolean",
      "yandexQuery": "boolean"
    },
    "zoneId": "string",
    "subnetId": "string",
    "assignPublicIp": "boolean",
    "fullVersion": "string"
  },
  "masterConfig": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "segmentConfig": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "masterHostCount": "string",
  "segmentInHost": "string",
  "segmentHostCount": "string",
  "userName": "string",
  "userPassword": "string",
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
  "configSpec": {
    // Includes only one of the fields `greenplumConfig_6`
    "greenplumConfig_6": {
      "maxConnections": "string",
      "maxSlotWalKeepSize": "string",
      "gpWorkfileLimitPerSegment": "string",
      "gpWorkfileLimitPerQuery": "string",
      "gpWorkfileLimitFilesPerQuery": "string",
      "maxPreparedTransactions": "string",
      "gpWorkfileCompression": "boolean",
      "maxStatementMem": "string",
      "logStatement": "string",
      "gpAddColumnInheritsTableSetting": "boolean",
      "gpEnableGlobalDeadlockDetector": "boolean",
      "gpGlobalDeadlockDetectorPeriod": "string",
      "gpMaxSlices": "string",
      "gpCachedSegworkersThreshold": "string",
      "lockTimeout": "string",
      "idleInTransactionSessionTimeout": "string",
      "runawayDetectorActivationPercent": "string",
      "gpVmemProtectSegworkerCacheLimit": "string",
      "gpEnableZstdMemoryAccounting": "boolean",
      "gpMaxPlanSize": "string",
      "gpAutostatsMode": "string",
      "gpAutostatsOnChangeThreshold": "string",
      "gpResourceGroupMemoryLimit": "number",
      "logConnections": "boolean",
      "logDisconnections": "boolean",
      "logHostname": "boolean",
      "logStatementStats": "boolean",
      "logMinDurationStatement": "string",
      "masterSharedBuffers": "string",
      "maxLocksPerTransaction": "string",
      "segmentSharedBuffers": "string",
      "logErrorVerbosity": "string",
      "logMinMessages": "string"
    },
    // end of the list of possible fields
    "pool": {
      "mode": "string",
      "size": "string",
      "clientIdleTimeout": "string",
      "idleInTransactionTimeout": "string"
    },
    "backgroundActivities": {
      "tableSizes": {
        "starts": [
          {
            "hours": "string",
            "minutes": "string"
          }
        ]
      },
      "analyzeAndVacuum": {
        "start": {
          "hours": "string",
          "minutes": "string"
        },
        "analyzeTimeout": "string",
        "vacuumTimeout": "string"
      },
      "queryKillerScripts": {
        "idle": {
          "enable": "boolean",
          "maxAge": "string",
          "ignoreUsers": [
            "string"
          ]
        },
        "idleInTransaction": {
          "enable": "boolean",
          "maxAge": "string",
          "ignoreUsers": [
            "string"
          ]
        },
        "longRunning": {
          "enable": "boolean",
          "maxAge": "string",
          "ignoreUsers": [
            "string"
          ]
        }
      }
    },
    "pxfConfig": {
      "connectionTimeout": "string",
      "uploadTimeout": "string",
      "maxThreads": "string",
      "poolAllowCoreThreadTimeout": "boolean",
      "poolCoreSize": "string",
      "poolQueueCapacity": "string",
      "poolMaxSize": "string",
      "xmx": "string",
      "xms": "string"
    }
  },
  "cloudStorage": {
    "enable": "boolean"
  },
  "masterHostGroupIds": [
    "string"
  ],
  "segmentHostGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "logging": {
    "enabled": "boolean",
    // Includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields
    "commandCenterEnabled": "boolean",
    "greenplumEnabled": "boolean",
    "poolerEnabled": "boolean"
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the Greenplum® cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Greenplum® cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the Greenplum® cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Greenplum® cluster as `key:value` pairs.
For example, `"project":"mvp"` or `"source":"dictionary"`.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|| environment | **enum** (Environment)

Required field. Deployment environment of the Greenplum® cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| config | **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig)**

Greenplum® cluster configuration. ||
|| masterConfig | **[MasterSubclusterConfigSpec](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfigSpec)**

Configuration of the Greenplum® master subcluster. ||
|| segmentConfig | **[SegmentSubclusterConfigSpec](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfigSpec)**

Configuration of the Greenplum® segment subcluster. ||
|| masterHostCount | **string** (int64)

Number of hosts in the master subcluster. ||
|| segmentInHost | **string** (int64)

Number of segments per host. ||
|| segmentHostCount | **string** (int64)

Number of hosts in the segment subcluster. ||
|| userName | **string**

Required field. Owner user name. ||
|| userPassword | **string**

Required field. Owner user password.

The string length in characters must be 8-128. ||
|| networkId | **string**

Required field. ID of the network to create the cluster in.

The maximum string length in characters is 50. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| hostGroupIds[] | **string**

Host groups to place VMs of the cluster in. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.greenplum.v1.ConfigSpec)**

Configuration of Greenplum® and Odyssey®. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage)**

Cloud storage settings ||
|| masterHostGroupIds[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segmentHostGroupIds[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|| serviceAccountId | **string**

ID of the service account used for access Yandex Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.mdb.greenplum.v1.LoggingConfig)**

Cloud logging configuration ||
|#

## GreenplumConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig}

#|
||Field | Description ||
|| version | **string**

Version of the Greenplum® server software. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups.

Acceptable values are 1 to 60, inclusive. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**

Access policy for external services. ||
|| zoneId | **string**

ID of the availability zone the cluster belongs to.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| subnetId | **string**

ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.networkId](#yandex.cloud.mdb.greenplum.v1.Cluster)).

The maximum string length in characters is 50. ||
|| assignPublicIp | **boolean**

Determines whether the cluster has a public IP address.

After the cluster has been created, this setting cannot be changed. ||
|| fullVersion | **string**

Full version ||
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

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows data export from the cluster to DataLens. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from the management console. ||
|| dataTransfer | **boolean**

Allows access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## MasterSubclusterConfigSpec {#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfigSpec}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources allocated to Greenplum® master subcluster hosts. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## SegmentSubclusterConfigSpec {#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfigSpec}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources allocated to Greenplum® segment subcluster hosts. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone.

Acceptable values are 1 to 24, inclusive. ||
|#

## ConfigSpec {#yandex.cloud.mdb.greenplum.v1.ConfigSpec}

#|
||Field | Description ||
|| greenplumConfig_6 | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Includes only one of the fields `greenplumConfig_6`. ||
|| pool | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Odyssey® pool settings. ||
|| backgroundActivities | **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig)**

Managed Greenplum® background tasks configuration. ||
|| pxfConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)** ||
|#

## GreenplumConfig6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment

Acceptable values are 50 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html

Acceptable values are 0 to 214748364800, inclusive. ||
|| gpWorkfileLimitPerSegment | **string** (int64)

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment

The minimum value is 0. ||
|| gpWorkfileLimitPerQuery | **string** (int64)

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query

Acceptable values are 0 to 1099511627776, inclusive. ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000

Acceptable values are 0 to 100000, inclusive. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html

Acceptable values are 50 to 10000, inclusive. ||
|| gpWorkfileCompression | **boolean**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **string** (int64)

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB)

Acceptable values are 134217728 to 1099511627776, inclusive. ||
|| logStatement | **enum** (LogStatement)

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
Default value is ddl

- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **boolean**

https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|| gpEnableGlobalDeadlockDetector | **boolean**

Controls whether the Greenplum Database Global Deadlock Detector is enabled to manage concurrent UPDATE and DELETE operations on heap tables to improve performance. See Inserting, Updating, and Deleting Datain the Greenplum Database Administrator Guide. The default is off, the Global Deadlock Detector is deactivated.
If the Global Deadlock Detector is deactivated (the default), Greenplum Database runs concurrent update and delete operations on a heap table serially.
If the Global Deadlock Detector is enabled, concurrent updates are permitted and the Global Deadlock Detector determines when a deadlock exists, and breaks the deadlock by cancelling one or more backend processes associated with the youngest transaction(s) involved.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector ||
|| gpGlobalDeadlockDetectorPeriod | **string** (int64)

Specifies the executing interval (in seconds) of the global deadlock detector background worker process.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period ||
|| gpMaxSlices | **string** (int64)

Max amount of slice-processes for one query in one segment.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_slices

Acceptable values are 10 to 100, inclusive. ||
|| gpCachedSegworkersThreshold | **string** (int64)

Define amount of working processes in segment, that keeping in warm cash after end of query for usage again in next queries.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_cached_segworkers_threshold

Acceptable values are 0 to 10, inclusive. ||
|| lockTimeout | **string** (int64)

Max time (in ms) which query will wait lock free on object
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#lock_timeout

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Max time (in ms) which session can idle in open transaction
https://postgrespro.ru/docs/postgrespro/current/runtime-config-client#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT

Acceptable values are 0 to 2147483647, inclusive. ||
|| runawayDetectorActivationPercent | **string** (int64)

Percent of utilized Greenplum Database vmem that triggers the termination of queries.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#runaway_detector_activation_percent

Acceptable values are 0 to 100, inclusive. ||
|| gpVmemProtectSegworkerCacheLimit | **string** (int64)

Set memory limit (in MB) for working process. If a query executor process consumes more than this configured amount, then the process will not be cached for use in subsequent queries after the process completes.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_vmem_protect_segworker_cache_limit

Acceptable values are 0 to 4096, inclusive. ||
|| gpEnableZstdMemoryAccounting | **boolean**

Forces ZSTD lib use Greenplum memory allocation system. ||
|| gpMaxPlanSize | **string** (int64)

Specifies the total maximum uncompressed size of a query execution plan multiplied by the number of Motion operators (slices) in the plan.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_plan_size

Acceptable values are 0 to 2147483647, inclusive. ||
|| gpAutostatsMode | **enum** (GPAutostatsMode)

Specifies the mode for triggering automatic statistics collection after DML.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_mode

- `GP_AUTOSTATS_MODE_NONE`: Disable auto-ANALYZE completely. Stats will be updated only via manual ANALYZE calls.
- `GP_AUTOSTATS_MODE_ON_CHANGE`: Run ANALYZE when data changes exceed threshold (e.g., after INSERT/UPDATE/DELETE).
- `GP_AUTOSTATS_MODE_ON_NO_STATS`: Run ANALYZE only if no stats exist (e.g., new or cleared table). ||
|| gpAutostatsOnChangeThreshold | **string** (int64)

Specifies the threshold for automatic statistics collection when gp_autostats_mode is set to on_change.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_on_change_threshold

Acceptable values are 0 to 2147483647, inclusive. ||
|| gpResourceGroupMemoryLimit | **number** (double)

Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum Database segment node.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_group_memory_limit ||
|| logConnections | **boolean**

This outputs a line to the server log detailing each successful connection. Some client programs, like psql,
attempt to connect twice while determining if a password is required, so duplicate "connection received" messages
do not always indicate a problem.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_connections ||
|| logDisconnections | **boolean**

This outputs a line in the server log at termination of a client session, and includes the duration of the session.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections ||
|| logHostname | **boolean**

By default, connection log messages only show the IP address of the connecting host.
Turning on this option causes logging of the host name as well. Note that depending on your host name
resolution setup this might impose a non-negligible performance penalty.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname ||
|| logStatementStats | **boolean**

For each query, write total performance statistics of the query parser, planner, and executor to the server log.
This is a crude profiling instrument.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats ||
|| logMinDurationStatement | **string** (int64)

Logs the statement and its duration on a single log line if its duration is greater than or equal
to the specified number of milliseconds. Setting this to 0 will print all statements and their durations.
-1 deactivates the feature. For example, if you set it to 250 then all SQL statements that run 250ms or longer will be logged.
Enabling this option can be useful in tracking down unoptimized queries in your applications.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement ||
|| masterSharedBuffers | **string** (int64)

Sets the amount of memory a Greenplum Database master instance uses for shared memory buffers.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers

Acceptable values are 1048576 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

The shared lock table is created with room to describe locks on max_locks_per_transaction * (max_connections + max_prepared_transactions) objects,
so no more than this many distinct objects can be locked at any one time.
This is not a hard limit on the number of locks taken by any one transaction, but rather a maximum average value.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#max_locks_per_transaction

Acceptable values are 128 to 2048, inclusive. ||
|| segmentSharedBuffers | **string** (int64)

Sets the amount of memory a Greenplum Database segment instance uses for shared memory buffers.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers

Acceptable values are 1048576 to 2147483647, inclusive. ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Controls the amount of detail written in the server log for each message that is logged.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity

- `TERSE`
- `DEFAULT`
- `VERBOSE` ||
|| logMinMessages | **enum** (LogLevelMessage)

Controls which message levels are written to the server log.
Each level includes all the levels that follow it. The later the level, the fewer messages are sent to the log.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages

- `DEBUG5`
- `DEBUG4`
- `DEBUG3`
- `DEBUG2`
- `DEBUG1`
- `INFO`
- `NOTICE`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| mode | **enum** (PoolMode)

Route server pool mode.

- `SESSION`: Assign server connection to a client until it disconnects. Default value.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| size | **string** (int64)

The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.

Set to zero to disable the limit. ||
|| clientIdleTimeout | **string** (int64)

Client pool idle timeout, in seconds.

Drop stale client connection after this much seconds of idleness, which is not in transaction.

Set to zero to disable. ||
|| idleInTransactionTimeout | **string** (int64)

Client pool idle in transaction timeout, in seconds.

Drop client connection in transaction after this much seconds of idleness.

Set to zero to disable. ||
|#

## BackgroundActivitiesConfig {#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig}

Configuration for long running queries killer.

#|
||Field | Description ||
|| tableSizes | **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes)**

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema. ||
|| analyzeAndVacuum | **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum)**

Configuration for `ANALYZE` and `VACUUM` operations. ||
|| queryKillerScripts | **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts)**

Configuration for long running queries killer. ||
|#

## TableSizes {#yandex.cloud.mdb.greenplum.v1.TableSizes}

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema.

#|
||Field | Description ||
|| starts[] | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)**

Time when start "table_sizes" script

The maximum number of elements is 4. ||
|#

## BackgroundActivityStartAt {#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt}

Start time for background activity

#|
||Field | Description ||
|| hours | **string** (int64)

hours

Acceptable values are 0 to 23, inclusive. ||
|| minutes | **string** (int64)

minutes

Acceptable values are 0 to 59, inclusive. ||
|#

## AnalyzeAndVacuum {#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum}

Configuration for `ANALYZE` and `VACUUM` operations.

#|
||Field | Description ||
|| start | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)**

Time when analyze will start ||
|| analyzeTimeout | **string** (int64)

Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.

Acceptable values are 7200 to 86399, inclusive. ||
|| vacuumTimeout | **string** (int64)

Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.

Acceptable values are 7200 to 86399, inclusive. ||
|#

## QueryKillerScripts {#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts}

#|
||Field | Description ||
|| idle | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle` state. ||
|| idleInTransaction | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle in transaction` state. ||
|| longRunning | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries (in any state). ||
|#

## QueryKiller {#yandex.cloud.mdb.greenplum.v1.QueryKiller}

#|
||Field | Description ||
|| enable | **boolean**

Use query killer or not ||
|| maxAge | **string** (int64)

Maximum duration for this type of queries (in seconds).

Acceptable values are 1 to 86400, inclusive. ||
|| ignoreUsers[] | **string**

Ignore these users when considering queries to terminate ||
|#

## PXFConfig {#yandex.cloud.mdb.greenplum.v1.PXFConfig}

#|
||Field | Description ||
|| connectionTimeout | **string** (int64)

Timeout for connection to the Apache Tomcat® server when making read requests.

Specify values in seconds.

Acceptable values are 5 to 600, inclusive. ||
|| uploadTimeout | **string** (int64)

Timeout for connection to the Apache Tomcat® server when making write requests.

Specify the values in seconds.

Acceptable values are 5 to 600, inclusive. ||
|| maxThreads | **string** (int64)

Maximum number of the Apache Tomcat® threads.

To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-9/gp-pxf/cfg_mem.html) documentation.

Acceptable values are 1 to 1024, inclusive. ||
|| poolAllowCoreThreadTimeout | **boolean**

Determines whether the timeout for core streaming threads is permitted. ||
|| poolCoreSize | **string** (int64)

Number of core streaming threads per pool.

Acceptable values are 1 to 1024, inclusive. ||
|| poolQueueCapacity | **string** (int64)

Maximum number of requests you can add to a pool queue for core streaming threads.

If `0`, no pool queue is generated.

The minimum value is 0. ||
|| poolMaxSize | **string** (int64)

Maximum allowed number of core streaming threads.

Acceptable values are 1 to 1024, inclusive. ||
|| xmx | **string** (int64)

Initial size, in megabytes, of the JVM heap for the PXF daemon.

The minimum value is 64. ||
|| xms | **string** (int64)

Maximum size, in megabytes, of the JVM heap for the PXF daemon.

The minimum value is 64. ||
|#

## CloudStorage {#yandex.cloud.mdb.greenplum.v1.CloudStorage}

Cloud Storage Settings

#|
||Field | Description ||
|| enable | **boolean**

enable Cloud Storage for cluster ||
|#

## LoggingConfig {#yandex.cloud.mdb.greenplum.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| folderId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| logGroupId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| commandCenterEnabled | **boolean**

send Yandex Command Center logs ||
|| greenplumEnabled | **boolean**

send Greenplum logs ||
|| poolerEnabled | **boolean**

send Pooler logs ||
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
    "config": {
      "version": "string",
      "backupWindowStart": {
        "hours": "integer",
        "minutes": "integer",
        "seconds": "integer",
        "nanos": "integer"
      },
      "backupRetainPeriodDays": "string",
      "access": {
        "dataLens": "boolean",
        "webSql": "boolean",
        "dataTransfer": "boolean",
        "yandexQuery": "boolean"
      },
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "fullVersion": "string"
    },
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
    "masterConfig": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "segmentConfig": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "masterHostCount": "string",
    "segmentHostCount": "string",
    "segmentInHost": "string",
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
    "userName": "string",
    "deletionProtection": "boolean",
    "hostGroupIds": [
      "string"
    ],
    "clusterConfig": {
      // Includes only one of the fields `greenplumConfigSet_6`
      "greenplumConfigSet_6": {
        "effectiveConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean",
          "gpEnableGlobalDeadlockDetector": "boolean",
          "gpGlobalDeadlockDetectorPeriod": "string",
          "gpMaxSlices": "string",
          "gpCachedSegworkersThreshold": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "runawayDetectorActivationPercent": "string",
          "gpVmemProtectSegworkerCacheLimit": "string",
          "gpEnableZstdMemoryAccounting": "boolean",
          "gpMaxPlanSize": "string",
          "gpAutostatsMode": "string",
          "gpAutostatsOnChangeThreshold": "string",
          "gpResourceGroupMemoryLimit": "number",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logHostname": "boolean",
          "logStatementStats": "boolean",
          "logMinDurationStatement": "string",
          "masterSharedBuffers": "string",
          "maxLocksPerTransaction": "string",
          "segmentSharedBuffers": "string",
          "logErrorVerbosity": "string",
          "logMinMessages": "string"
        },
        "userConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean",
          "gpEnableGlobalDeadlockDetector": "boolean",
          "gpGlobalDeadlockDetectorPeriod": "string",
          "gpMaxSlices": "string",
          "gpCachedSegworkersThreshold": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "runawayDetectorActivationPercent": "string",
          "gpVmemProtectSegworkerCacheLimit": "string",
          "gpEnableZstdMemoryAccounting": "boolean",
          "gpMaxPlanSize": "string",
          "gpAutostatsMode": "string",
          "gpAutostatsOnChangeThreshold": "string",
          "gpResourceGroupMemoryLimit": "number",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logHostname": "boolean",
          "logStatementStats": "boolean",
          "logMinDurationStatement": "string",
          "masterSharedBuffers": "string",
          "maxLocksPerTransaction": "string",
          "segmentSharedBuffers": "string",
          "logErrorVerbosity": "string",
          "logMinMessages": "string"
        },
        "defaultConfig": {
          "maxConnections": "string",
          "maxSlotWalKeepSize": "string",
          "gpWorkfileLimitPerSegment": "string",
          "gpWorkfileLimitPerQuery": "string",
          "gpWorkfileLimitFilesPerQuery": "string",
          "maxPreparedTransactions": "string",
          "gpWorkfileCompression": "boolean",
          "maxStatementMem": "string",
          "logStatement": "string",
          "gpAddColumnInheritsTableSetting": "boolean",
          "gpEnableGlobalDeadlockDetector": "boolean",
          "gpGlobalDeadlockDetectorPeriod": "string",
          "gpMaxSlices": "string",
          "gpCachedSegworkersThreshold": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "runawayDetectorActivationPercent": "string",
          "gpVmemProtectSegworkerCacheLimit": "string",
          "gpEnableZstdMemoryAccounting": "boolean",
          "gpMaxPlanSize": "string",
          "gpAutostatsMode": "string",
          "gpAutostatsOnChangeThreshold": "string",
          "gpResourceGroupMemoryLimit": "number",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logHostname": "boolean",
          "logStatementStats": "boolean",
          "logMinDurationStatement": "string",
          "masterSharedBuffers": "string",
          "maxLocksPerTransaction": "string",
          "segmentSharedBuffers": "string",
          "logErrorVerbosity": "string",
          "logMinMessages": "string"
        }
      },
      // end of the list of possible fields
      "pool": {
        "effectiveConfig": {
          "mode": "string",
          "size": "string",
          "clientIdleTimeout": "string",
          "idleInTransactionTimeout": "string"
        },
        "userConfig": {
          "mode": "string",
          "size": "string",
          "clientIdleTimeout": "string",
          "idleInTransactionTimeout": "string"
        },
        "defaultConfig": {
          "mode": "string",
          "size": "string",
          "clientIdleTimeout": "string",
          "idleInTransactionTimeout": "string"
        }
      },
      "backgroundActivities": {
        "tableSizes": {
          "starts": [
            {
              "hours": "string",
              "minutes": "string"
            }
          ]
        },
        "analyzeAndVacuum": {
          "start": {
            "hours": "string",
            "minutes": "string"
          },
          "analyzeTimeout": "string",
          "vacuumTimeout": "string"
        },
        "queryKillerScripts": {
          "idle": {
            "enable": "boolean",
            "maxAge": "string",
            "ignoreUsers": [
              "string"
            ]
          },
          "idleInTransaction": {
            "enable": "boolean",
            "maxAge": "string",
            "ignoreUsers": [
              "string"
            ]
          },
          "longRunning": {
            "enable": "boolean",
            "maxAge": "string",
            "ignoreUsers": [
              "string"
            ]
          }
        }
      },
      "pxfConfig": {
        "effectiveConfig": {
          "connectionTimeout": "string",
          "uploadTimeout": "string",
          "maxThreads": "string",
          "poolAllowCoreThreadTimeout": "boolean",
          "poolCoreSize": "string",
          "poolQueueCapacity": "string",
          "poolMaxSize": "string",
          "xmx": "string",
          "xms": "string"
        },
        "userConfig": {
          "connectionTimeout": "string",
          "uploadTimeout": "string",
          "maxThreads": "string",
          "poolAllowCoreThreadTimeout": "boolean",
          "poolCoreSize": "string",
          "poolQueueCapacity": "string",
          "poolMaxSize": "string",
          "xmx": "string",
          "xms": "string"
        },
        "defaultConfig": {
          "connectionTimeout": "string",
          "uploadTimeout": "string",
          "maxThreads": "string",
          "poolAllowCoreThreadTimeout": "boolean",
          "poolCoreSize": "string",
          "poolQueueCapacity": "string",
          "poolMaxSize": "string",
          "xmx": "string",
          "xms": "string"
        }
      }
    },
    "cloudStorage": {
      "enable": "boolean"
    },
    "masterHostGroupIds": [
      "string"
    ],
    "segmentHostGroupIds": [
      "string"
    ],
    "serviceAccountId": "string",
    "logging": {
      "enabled": "boolean",
      // Includes only one of the fields `folderId`, `logGroupId`
      "folderId": "string",
      "logGroupId": "string",
      // end of the list of possible fields
      "commandCenterEnabled": "boolean",
      "greenplumEnabled": "boolean",
      "poolerEnabled": "boolean"
    }
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
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.greenplum.v1.CreateClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.greenplum.v1.Cluster)**

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

## CreateClusterMetadata {#yandex.cloud.mdb.greenplum.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Greenplum® cluster that is being created. ||
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

## Cluster {#yandex.cloud.mdb.greenplum.v1.Cluster}

A Greenplum® cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the Greenplum® cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folderId | **string**

ID of the folder that the Greenplum® cluster belongs to. ||
|| createdAt | **string** (date-time)

Time when the cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Required field. Name of the Greenplum® cluster.
The name is unique within the folder.

The maximum string length in characters is 63. ||
|| config | **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig2)**

Greenplum® cluster configuration. ||
|| description | **string**

Description of the Greenplum® cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the Greenplum® cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.greenplum.v1.Monitoring)**

Description of monitoring systems relevant to the Greenplum® cluster. ||
|| masterConfig | **[MasterSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig)**

Configuration of the Greenplum® master subcluster. ||
|| segmentConfig | **[SegmentSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig)**

Configuration of the Greenplum® segment subcluster. ||
|| masterHostCount | **string** (int64)

Number of hosts in the master subcluster. ||
|| segmentHostCount | **string** (int64)

Number of hosts in the segment subcluster. ||
|| segmentInHost | **string** (int64)

Number of segments per host. ||
|| networkId | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is not ALIVE).
- `UNBALANCED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is UNBALANCED). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster has encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster has stopped.
- `STARTING`: Cluster is starting. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow2)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| userName | **string**

Owner user name. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| clusterConfig | **[ClusterConfigSet](#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet)**

Greenplum® and Odyssey® configuration. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage2)**

Cloud storage settings ||
|| masterHostGroupIds[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segmentHostGroupIds[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|| serviceAccountId | **string**

Service account that will be used to access a Yandex Cloud resources ||
|| logging | **[LoggingConfig](#yandex.cloud.mdb.greenplum.v1.LoggingConfig2)**

Cloud logging configuration ||
|#

## GreenplumConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig2}

#|
||Field | Description ||
|| version | **string**

Version of the Greenplum® server software. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay2)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retention policy of automated backups.

Acceptable values are 1 to 60, inclusive. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access2)**

Access policy for external services. ||
|| zoneId | **string**

ID of the availability zone the cluster belongs to.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| subnetId | **string**

ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.networkId](#yandex.cloud.mdb.greenplum.v1.Cluster)).

The maximum string length in characters is 50. ||
|| assignPublicIp | **boolean**

Determines whether the cluster has a public IP address.

After the cluster has been created, this setting cannot be changed. ||
|| fullVersion | **string**

Full version ||
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

## Access {#yandex.cloud.mdb.greenplum.v1.Access2}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows data export from the cluster to DataLens. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from the management console. ||
|| dataTransfer | **boolean**

Allows access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## Monitoring {#yandex.cloud.mdb.greenplum.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Greenplum® cluster. ||
|#

## MasterSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources2)**

Computational resources allocated to Greenplum® master subcluster hosts. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## SegmentSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources2)**

Computational resources allocated to Greenplum® segment subcluster hosts. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow2)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow2}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone.

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation.

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

Delay time for the maintenance operation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## ClusterConfigSet {#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet}

#|
||Field | Description ||
|| greenplumConfigSet_6 | **[GreenplumConfigSet6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6)**

Includes only one of the fields `greenplumConfigSet_6`. ||
|| pool | **[ConnectionPoolerConfigSet](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet)**

Odyssey® pool settings. ||
|| backgroundActivities | **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig2)**

Managed Greenplum® background tasks configuration. ||
|| pxfConfig | **[PXFConfigSet](#yandex.cloud.mdb.greenplum.v1.PXFConfigSet)** ||
|#

## GreenplumConfigSet6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig62)**

Required field. Effective settings for a Greenplum (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig62)**

User-defined settings for a Greenplum. ||
|| defaultConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig62)**

Default configuration for a Greenplum. ||
|#

## GreenplumConfig6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig62}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections on master segment

Acceptable values are 50 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html

Acceptable values are 0 to 214748364800, inclusive. ||
|| gpWorkfileLimitPerSegment | **string** (int64)

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment

The minimum value is 0. ||
|| gpWorkfileLimitPerQuery | **string** (int64)

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query

Acceptable values are 0 to 1099511627776, inclusive. ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000

Acceptable values are 0 to 100000, inclusive. ||
|| maxPreparedTransactions | **string** (int64)

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html

Acceptable values are 50 to 10000, inclusive. ||
|| gpWorkfileCompression | **boolean**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression ||
|| maxStatementMem | **string** (int64)

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB)

Acceptable values are 134217728 to 1099511627776, inclusive. ||
|| logStatement | **enum** (LogStatement)

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
Default value is ddl

- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gpAddColumnInheritsTableSetting | **boolean**

https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|| gpEnableGlobalDeadlockDetector | **boolean**

Controls whether the Greenplum Database Global Deadlock Detector is enabled to manage concurrent UPDATE and DELETE operations on heap tables to improve performance. See Inserting, Updating, and Deleting Datain the Greenplum Database Administrator Guide. The default is off, the Global Deadlock Detector is deactivated.
If the Global Deadlock Detector is deactivated (the default), Greenplum Database runs concurrent update and delete operations on a heap table serially.
If the Global Deadlock Detector is enabled, concurrent updates are permitted and the Global Deadlock Detector determines when a deadlock exists, and breaks the deadlock by cancelling one or more backend processes associated with the youngest transaction(s) involved.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector ||
|| gpGlobalDeadlockDetectorPeriod | **string** (int64)

Specifies the executing interval (in seconds) of the global deadlock detector background worker process.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period ||
|| gpMaxSlices | **string** (int64)

Max amount of slice-processes for one query in one segment.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_slices

Acceptable values are 10 to 100, inclusive. ||
|| gpCachedSegworkersThreshold | **string** (int64)

Define amount of working processes in segment, that keeping in warm cash after end of query for usage again in next queries.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_cached_segworkers_threshold

Acceptable values are 0 to 10, inclusive. ||
|| lockTimeout | **string** (int64)

Max time (in ms) which query will wait lock free on object
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#lock_timeout

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Max time (in ms) which session can idle in open transaction
https://postgrespro.ru/docs/postgrespro/current/runtime-config-client#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT

Acceptable values are 0 to 2147483647, inclusive. ||
|| runawayDetectorActivationPercent | **string** (int64)

Percent of utilized Greenplum Database vmem that triggers the termination of queries.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#runaway_detector_activation_percent

Acceptable values are 0 to 100, inclusive. ||
|| gpVmemProtectSegworkerCacheLimit | **string** (int64)

Set memory limit (in MB) for working process. If a query executor process consumes more than this configured amount, then the process will not be cached for use in subsequent queries after the process completes.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_vmem_protect_segworker_cache_limit

Acceptable values are 0 to 4096, inclusive. ||
|| gpEnableZstdMemoryAccounting | **boolean**

Forces ZSTD lib use Greenplum memory allocation system. ||
|| gpMaxPlanSize | **string** (int64)

Specifies the total maximum uncompressed size of a query execution plan multiplied by the number of Motion operators (slices) in the plan.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_plan_size

Acceptable values are 0 to 2147483647, inclusive. ||
|| gpAutostatsMode | **enum** (GPAutostatsMode)

Specifies the mode for triggering automatic statistics collection after DML.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_mode

- `GP_AUTOSTATS_MODE_NONE`: Disable auto-ANALYZE completely. Stats will be updated only via manual ANALYZE calls.
- `GP_AUTOSTATS_MODE_ON_CHANGE`: Run ANALYZE when data changes exceed threshold (e.g., after INSERT/UPDATE/DELETE).
- `GP_AUTOSTATS_MODE_ON_NO_STATS`: Run ANALYZE only if no stats exist (e.g., new or cleared table). ||
|| gpAutostatsOnChangeThreshold | **string** (int64)

Specifies the threshold for automatic statistics collection when gp_autostats_mode is set to on_change.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_on_change_threshold

Acceptable values are 0 to 2147483647, inclusive. ||
|| gpResourceGroupMemoryLimit | **number** (double)

Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum Database segment node.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_group_memory_limit ||
|| logConnections | **boolean**

This outputs a line to the server log detailing each successful connection. Some client programs, like psql,
attempt to connect twice while determining if a password is required, so duplicate "connection received" messages
do not always indicate a problem.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_connections ||
|| logDisconnections | **boolean**

This outputs a line in the server log at termination of a client session, and includes the duration of the session.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections ||
|| logHostname | **boolean**

By default, connection log messages only show the IP address of the connecting host.
Turning on this option causes logging of the host name as well. Note that depending on your host name
resolution setup this might impose a non-negligible performance penalty.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname ||
|| logStatementStats | **boolean**

For each query, write total performance statistics of the query parser, planner, and executor to the server log.
This is a crude profiling instrument.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats ||
|| logMinDurationStatement | **string** (int64)

Logs the statement and its duration on a single log line if its duration is greater than or equal
to the specified number of milliseconds. Setting this to 0 will print all statements and their durations.
-1 deactivates the feature. For example, if you set it to 250 then all SQL statements that run 250ms or longer will be logged.
Enabling this option can be useful in tracking down unoptimized queries in your applications.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement ||
|| masterSharedBuffers | **string** (int64)

Sets the amount of memory a Greenplum Database master instance uses for shared memory buffers.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers

Acceptable values are 1048576 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

The shared lock table is created with room to describe locks on max_locks_per_transaction * (max_connections + max_prepared_transactions) objects,
so no more than this many distinct objects can be locked at any one time.
This is not a hard limit on the number of locks taken by any one transaction, but rather a maximum average value.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#max_locks_per_transaction

Acceptable values are 128 to 2048, inclusive. ||
|| segmentSharedBuffers | **string** (int64)

Sets the amount of memory a Greenplum Database segment instance uses for shared memory buffers.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers

Acceptable values are 1048576 to 2147483647, inclusive. ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Controls the amount of detail written in the server log for each message that is logged.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity

- `TERSE`
- `DEFAULT`
- `VERBOSE` ||
|| logMinMessages | **enum** (LogLevelMessage)

Controls which message levels are written to the server log.
Each level includes all the levels that follow it. The later the level, the fewer messages are sent to the log.
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages

- `DEBUG5`
- `DEBUG4`
- `DEBUG3`
- `DEBUG2`
- `DEBUG1`
- `INFO`
- `NOTICE`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|#

## ConnectionPoolerConfigSet {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig2)**

Required field. Effective settings for an Odyssey® pooler (a combination of settings defined in `ConnectionPoolerConfigSet.userConfig` and `ConnectionPoolerConfigSet.defaultConfig`). ||
|| userConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig2)**

User-defined settings for an Odyssey® pooler. ||
|| defaultConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig2)**

Default configuration for an Odyssey® pooler. ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig2}

#|
||Field | Description ||
|| mode | **enum** (PoolMode)

Route server pool mode.

- `SESSION`: Assign server connection to a client until it disconnects. Default value.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| size | **string** (int64)

The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.

Set to zero to disable the limit. ||
|| clientIdleTimeout | **string** (int64)

Client pool idle timeout, in seconds.

Drop stale client connection after this much seconds of idleness, which is not in transaction.

Set to zero to disable. ||
|| idleInTransactionTimeout | **string** (int64)

Client pool idle in transaction timeout, in seconds.

Drop client connection in transaction after this much seconds of idleness.

Set to zero to disable. ||
|#

## BackgroundActivitiesConfig {#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig2}

Configuration for long running queries killer.

#|
||Field | Description ||
|| tableSizes | **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes2)**

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema. ||
|| analyzeAndVacuum | **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum2)**

Configuration for `ANALYZE` and `VACUUM` operations. ||
|| queryKillerScripts | **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts2)**

Configuration for long running queries killer. ||
|#

## TableSizes {#yandex.cloud.mdb.greenplum.v1.TableSizes2}

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema.

#|
||Field | Description ||
|| starts[] | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt2)**

Time when start "table_sizes" script

The maximum number of elements is 4. ||
|#

## BackgroundActivityStartAt {#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt2}

Start time for background activity

#|
||Field | Description ||
|| hours | **string** (int64)

hours

Acceptable values are 0 to 23, inclusive. ||
|| minutes | **string** (int64)

minutes

Acceptable values are 0 to 59, inclusive. ||
|#

## AnalyzeAndVacuum {#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum2}

Configuration for `ANALYZE` and `VACUUM` operations.

#|
||Field | Description ||
|| start | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt2)**

Time when analyze will start ||
|| analyzeTimeout | **string** (int64)

Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.

Acceptable values are 7200 to 86399, inclusive. ||
|| vacuumTimeout | **string** (int64)

Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.

Acceptable values are 7200 to 86399, inclusive. ||
|#

## QueryKillerScripts {#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts2}

#|
||Field | Description ||
|| idle | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller2)**

Configuration of script that kills long running queries that are in `idle` state. ||
|| idleInTransaction | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller2)**

Configuration of script that kills long running queries that are in `idle in transaction` state. ||
|| longRunning | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller2)**

Configuration of script that kills long running queries (in any state). ||
|#

## QueryKiller {#yandex.cloud.mdb.greenplum.v1.QueryKiller2}

#|
||Field | Description ||
|| enable | **boolean**

Use query killer or not ||
|| maxAge | **string** (int64)

Maximum duration for this type of queries (in seconds).

Acceptable values are 1 to 86400, inclusive. ||
|| ignoreUsers[] | **string**

Ignore these users when considering queries to terminate ||
|#

## PXFConfigSet {#yandex.cloud.mdb.greenplum.v1.PXFConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig2)**

Required field. ||
|| userConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig2)**

User-defined settings. ||
|| defaultConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig2)**

Default configuration. ||
|#

## PXFConfig {#yandex.cloud.mdb.greenplum.v1.PXFConfig2}

#|
||Field | Description ||
|| connectionTimeout | **string** (int64)

Timeout for connection to the Apache Tomcat® server when making read requests.

Specify values in seconds.

Acceptable values are 5 to 600, inclusive. ||
|| uploadTimeout | **string** (int64)

Timeout for connection to the Apache Tomcat® server when making write requests.

Specify the values in seconds.

Acceptable values are 5 to 600, inclusive. ||
|| maxThreads | **string** (int64)

Maximum number of the Apache Tomcat® threads.

To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-9/gp-pxf/cfg_mem.html) documentation.

Acceptable values are 1 to 1024, inclusive. ||
|| poolAllowCoreThreadTimeout | **boolean**

Determines whether the timeout for core streaming threads is permitted. ||
|| poolCoreSize | **string** (int64)

Number of core streaming threads per pool.

Acceptable values are 1 to 1024, inclusive. ||
|| poolQueueCapacity | **string** (int64)

Maximum number of requests you can add to a pool queue for core streaming threads.

If `0`, no pool queue is generated.

The minimum value is 0. ||
|| poolMaxSize | **string** (int64)

Maximum allowed number of core streaming threads.

Acceptable values are 1 to 1024, inclusive. ||
|| xmx | **string** (int64)

Initial size, in megabytes, of the JVM heap for the PXF daemon.

The minimum value is 64. ||
|| xms | **string** (int64)

Maximum size, in megabytes, of the JVM heap for the PXF daemon.

The minimum value is 64. ||
|#

## CloudStorage {#yandex.cloud.mdb.greenplum.v1.CloudStorage2}

Cloud Storage Settings

#|
||Field | Description ||
|| enable | **boolean**

enable Cloud Storage for cluster ||
|#

## LoggingConfig {#yandex.cloud.mdb.greenplum.v1.LoggingConfig2}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| folderId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| logGroupId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| commandCenterEnabled | **boolean**

send Yandex Command Center logs ||
|| greenplumEnabled | **boolean**

send Greenplum logs ||
|| poolerEnabled | **boolean**

send Pooler logs ||
|#