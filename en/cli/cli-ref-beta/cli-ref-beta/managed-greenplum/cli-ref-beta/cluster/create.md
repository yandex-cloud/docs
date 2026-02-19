---
editable: false
noIndex: true
---

# yc beta managed-greenplum cluster create

Creates a Greenplum® cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-greenplum cluster create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cloud-storage` | `shorthand/json`

Cloud storage settings

Shorthand Syntax:

```hcl
{
  enable = boolean
}
```

JSON Syntax:

```json
{
  "enable": "boolean"
}
```

Fields:

```
enable -> (boolean)
  enable Cloud Storage for cluster
``` ||
|| `--config` | `shorthand/json`

Greenplum® cluster configuration.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    data-transfer = boolean,
    web-sql = boolean,
    yandex-query = boolean
  },
  assign-public-ip = boolean,
  backup-retain-period-days = integer,
  backup-window-start = timeofday,
  full-version = string,
  subnet-id = string,
  version = string,
  zone-id = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "data-transfer": "boolean",
    "web-sql": "boolean",
    "yandex-query": "boolean"
  },
  "assign-public-ip": "boolean",
  "backup-retain-period-days": "integer",
  "backup-window-start": "timeofday",
  "full-version": "string",
  "subnet-id": "string",
  "version": "string",
  "zone-id": "string"
}
```

Fields:

```
access -> (struct)
  Access policy for external services.
  data-lens -> (boolean)
    Allows data export from the cluster to DataLens.
  data-transfer -> (boolean)
    Allows access for DataTransfer.
  web-sql -> (boolean)
    Allows SQL queries to the cluster databases from the management console.
  yandex-query -> (boolean)
    Allow access for YandexQuery.
assign-public-ip -> (boolean)
  Determines whether the cluster has a public IP address. After the cluster has been created, this setting cannot be changed.
backup-retain-period-days -> (integer)
  Retention policy of automated backups.
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
full-version -> (string)
  Full version
subnet-id -> (string)
  ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id]).
version -> (string)
  Version of the Greenplum® server software.
zone-id -> (string)
  ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--config-spec` | `shorthand/json`

Configuration of Greenplum® and Odyssey®.

Shorthand Syntax:

```hcl
{
  background-activities = {
    analyze-and-vacuum = {
      analyze-timeout = integer,
      start = {
        hours = integer,
        minutes = integer
      },
      vacuum-timeout = integer
    },
    query-killer-scripts = {
      idle = {
        enable = boolean,
        ignore-users = string,...,
        max-age = integer
      },
      idle-in-transaction = {
        enable = boolean,
        ignore-users = string,...,
        max-age = integer
      },
      long-running = {
        enable = boolean,
        ignore-users = string,...,
        max-age = integer
      }
    },
    table-sizes = {
      starts = [
        {
          hours = integer,
          minutes = integer
        }, ...
      ]
    }
  },
  greenplum-config = greenplum-config-6={
    gp-add-column-inherits-table-setting = boolean,
    gp-autostats-mode = GP_AUTOSTATS_MODE_NONE|GP_AUTOSTATS_MODE_ON_CHANGE|GP_AUTOSTATS_MODE_ON_NO_STATS,
    gp-autostats-on-change-threshold = integer,
    gp-cached-segworkers-threshold = integer,
    gp-enable-global-deadlock-detector = boolean,
    gp-enable-zstd-memory-accounting = boolean,
    gp-global-deadlock-detector-period = integer,
    gp-max-plan-size = integer,
    gp-max-slices = integer,
    gp-resource-group-memory-limit = float64,
    gp-vmem-protect-segworker-cache-limit = integer,
    gp-workfile-compression = boolean,
    gp-workfile-limit-files-per-query = integer,
    gp-workfile-limit-per-query = integer,
    gp-workfile-limit-per-segment = integer,
    idle-in-transaction-session-timeout = integer,
    lock-timeout = integer,
    log-connections = boolean,
    log-disconnections = boolean,
    log-error-verbosity = TERSE|DEFAULT|VERBOSE,
    log-hostname = boolean,
    log-min-duration-statement = integer,
    log-min-messages = DEBUG5|DEBUG4|DEBUG3|DEBUG2|DEBUG1|INFO|NOTICE|WARNING|ERROR|FATAL|PANIC,
    log-statement = NONE|DDL|MOD|ALL,
    log-statement-stats = boolean,
    master-shared-buffers = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-statement-mem = integer,
    runaway-detector-activation-percent = integer,
    segment-shared-buffers = integer
  },
  pool = {
    client-idle-timeout = integer,
    idle-in-transaction-timeout = integer,
    mode = SESSION|TRANSACTION,
    size = integer
  },
  pxf-config = {
    connection-timeout = integer,
    max-threads = integer,
    pool-allow-core-thread-timeout = boolean,
    pool-core-size = integer,
    pool-max-size = integer,
    pool-queue-capacity = integer,
    upload-timeout = integer,
    xms = integer,
    xmx = integer
  }
}
```

JSON Syntax:

```json
{
  "background-activities": {
    "analyze-and-vacuum": {
      "analyze-timeout": "integer",
      "start": {
        "hours": "integer",
        "minutes": "integer"
      },
      "vacuum-timeout": "integer"
    },
    "query-killer-scripts": {
      "idle": {
        "enable": "boolean",
        "ignore-users": [
          "string", ...
        ],
        "max-age": "integer"
      },
      "idle-in-transaction": {
        "enable": "boolean",
        "ignore-users": [
          "string", ...
        ],
        "max-age": "integer"
      },
      "long-running": {
        "enable": "boolean",
        "ignore-users": [
          "string", ...
        ],
        "max-age": "integer"
      }
    },
    "table-sizes": {
      "starts": [
        {
          "hours": "integer",
          "minutes": "integer"
        }, ...
      ]
    }
  },
  "greenplum-config": {
    "greenplum-config-6": {
      "gp-add-column-inherits-table-setting": "boolean",
      "gp-autostats-mode": "GP_AUTOSTATS_MODE_NONE|GP_AUTOSTATS_MODE_ON_CHANGE|GP_AUTOSTATS_MODE_ON_NO_STATS",
      "gp-autostats-on-change-threshold": "integer",
      "gp-cached-segworkers-threshold": "integer",
      "gp-enable-global-deadlock-detector": "boolean",
      "gp-enable-zstd-memory-accounting": "boolean",
      "gp-global-deadlock-detector-period": "integer",
      "gp-max-plan-size": "integer",
      "gp-max-slices": "integer",
      "gp-resource-group-memory-limit": "float64",
      "gp-vmem-protect-segworker-cache-limit": "integer",
      "gp-workfile-compression": "boolean",
      "gp-workfile-limit-files-per-query": "integer",
      "gp-workfile-limit-per-query": "integer",
      "gp-workfile-limit-per-segment": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "lock-timeout": "integer",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-error-verbosity": "TERSE|DEFAULT|VERBOSE",
      "log-hostname": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-messages": "DEBUG5|DEBUG4|DEBUG3|DEBUG2|DEBUG1|INFO|NOTICE|WARNING|ERROR|FATAL|PANIC",
      "log-statement": "NONE|DDL|MOD|ALL",
      "log-statement-stats": "boolean",
      "master-shared-buffers": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-statement-mem": "integer",
      "runaway-detector-activation-percent": "integer",
      "segment-shared-buffers": "integer"
    }
  },
  "pool": {
    "client-idle-timeout": "integer",
    "idle-in-transaction-timeout": "integer",
    "mode": "SESSION|TRANSACTION",
    "size": "integer"
  },
  "pxf-config": {
    "connection-timeout": "integer",
    "max-threads": "integer",
    "pool-allow-core-thread-timeout": "boolean",
    "pool-core-size": "integer",
    "pool-max-size": "integer",
    "pool-queue-capacity": "integer",
    "upload-timeout": "integer",
    "xms": "integer",
    "xmx": "integer"
  }
}
```

Fields:

```
background-activities -> (struct)
  Managed Greenplum® background tasks configuration.
  analyze-and-vacuum -> (struct)
    Configuration for 'ANALYZE' and 'VACUUM' operations.
    analyze-timeout -> (integer)
      Maximum duration of the 'ANALYZE' operation, in seconds. The default value is '36000'. As soon as this period expires, the 'ANALYZE' operation will be forced to terminate.
    start -> (struct)
      Time when analyze will start
      hours -> (integer)
        hours
      minutes -> (integer)
        minutes
    vacuum-timeout -> (integer)
      Maximum duration of the 'VACUUM' operation, in seconds. The default value is '36000'. As soon as this period expires, the 'VACUUM' operation will be forced to terminate.
  query-killer-scripts -> (struct)
    Configuration for long running queries killer.
    idle -> (struct)
      Configuration of script that kills long running queries that are in 'idle' state.
      enable -> (boolean)
        Use query killer or not
      ignore-users -> ([]string)
        Ignore these users when considering queries to terminate
      max-age -> (integer)
        Maximum duration for this type of queries (in seconds).
    idle-in-transaction -> (struct)
      Configuration of script that kills long running queries that are in 'idle in transaction' state.
      enable -> (boolean)
        Use query killer or not
      ignore-users -> ([]string)
        Ignore these users when considering queries to terminate
      max-age -> (integer)
        Maximum duration for this type of queries (in seconds).
    long-running -> (struct)
      Configuration of script that kills long running queries (in any state).
      enable -> (boolean)
        Use query killer or not
      ignore-users -> ([]string)
        Ignore these users when considering queries to terminate
      max-age -> (integer)
        Maximum duration for this type of queries (in seconds).
  table-sizes -> (struct)
    Enables scripts that collects tables sizes to '*_sizes' tables in 'mdb_toolkit' schema.
    starts -> ([]struct)
      Time when start "table_sizes" script
      hours -> (integer)
        hours
      minutes -> (integer)
        minutes
pool -> (struct)
  Odyssey® pool settings.
  client-idle-timeout -> (integer)
    Client pool idle timeout, in seconds. Drop stale client connection after this much seconds of idleness, which is not in transaction. Set to zero to disable.
  idle-in-transaction-timeout -> (integer)
    Client pool idle in transaction timeout, in seconds. Drop client connection in transaction after this much seconds of idleness. Set to zero to disable.
  mode -> (struct)
    Route server pool mode.
  size -> (integer)
    The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit.
pxf-config -> (struct)
  connection-timeout -> (integer)
    Timeout for connection to the Apache Tomcat® server when making read requests. Specify values in seconds.
  max-threads -> (integer)
    Maximum number of the Apache Tomcat® threads. To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the VMware Greenplum® Platform Extension Framework documentation.
  pool-allow-core-thread-timeout -> (boolean)
    Determines whether the timeout for core streaming threads is permitted.
  pool-core-size -> (integer)
    Number of core streaming threads per pool.
  pool-max-size -> (integer)
    Maximum allowed number of core streaming threads.
  pool-queue-capacity -> (integer)
    Maximum number of requests you can add to a pool queue for core streaming threads. If '0', no pool queue is generated.
  upload-timeout -> (integer)
    Timeout for connection to the Apache Tomcat® server when making write requests. Specify the values in seconds.
  xms -> (integer)
    Maximum size, in megabytes, of the JVM heap for the PXF daemon.
  xmx -> (integer)
    Initial size, in megabytes, of the JVM heap for the PXF daemon.
greenplum-config -> (oneof<greenplum-config-6>)
  Oneof greenplum-config field
  greenplum-config-6 -> (struct)
    gp-add-column-inherits-table-setting -> (boolean)
      https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting
    gp-autostats-mode -> (struct)
      Specifies the mode for triggering automatic statistics collection after DML. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_mode
    gp-autostats-on-change-threshold -> (integer)
      Specifies the threshold for automatic statistics collection when gp_autostats_mode is set to on_change. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_on_change_threshold
    gp-cached-segworkers-threshold -> (integer)
      Define amount of working processes in segment, that keeping in warm cash after end of query for usage again in next queries. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_cached_segworkers_threshold
    gp-enable-global-deadlock-detector -> (boolean)
      Controls whether the Greenplum Database Global Deadlock Detector is enabled to manage concurrent UPDATE and DELETE operations on heap tables to improve performance. See Inserting, Updating, and Deleting Datain the Greenplum Database Administrator Guide. The default is off, the Global Deadlock Detector is deactivated. If the Global Deadlock Detector is deactivated (the default), Greenplum Database runs concurrent update and delete operations on a heap table serially. If the Global Deadlock Detector is enabled, concurrent updates are permitted and the Global Deadlock Detector determines when a deadlock exists, and breaks the deadlock by cancelling one or more backend processes associated with the youngest transaction(s) involved. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector
    gp-enable-zstd-memory-accounting -> (boolean)
      Forces ZSTD lib use Greenplum memory allocation system.
    gp-global-deadlock-detector-period -> (integer)
      Specifies the executing interval (in seconds) of the global deadlock detector background worker process. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period
    gp-max-plan-size -> (integer)
      Specifies the total maximum uncompressed size of a query execution plan multiplied by the number of Motion operators (slices) in the plan. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_plan_size
    gp-max-slices -> (integer)
      Max amount of slice-processes for one query in one segment. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_slices
    gp-resource-group-memory-limit -> (float64)
      Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum Database segment node. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_group_memory_limit
    gp-vmem-protect-segworker-cache-limit -> (integer)
      Set memory limit (in MB) for working process. If a query executor process consumes more than this configured amount, then the process will not be cached for use in subsequent queries after the process completes. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_vmem_protect_segworker_cache_limit
    gp-workfile-compression -> (boolean)
      Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression
    gp-workfile-limit-files-per-query -> (integer)
      Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000
    gp-workfile-limit-per-query -> (integer)
      Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query
    gp-workfile-limit-per-segment -> (integer)
      Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment
    idle-in-transaction-session-timeout -> (integer)
      Max time (in ms) which session can idle in open transaction https://postgrespro.ru/docs/postgrespro/current/runtime-config-client#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT
    lock-timeout -> (integer)
      Max time (in ms) which query will wait lock free on object https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#lock_timeout
    log-connections -> (boolean)
      This outputs a line to the server log detailing each successful connection. Some client programs, like psql, attempt to connect twice while determining if a password is required, so duplicate "connection received" messages do not always indicate a problem. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_connections
    log-disconnections -> (boolean)
      This outputs a line in the server log at termination of a client session, and includes the duration of the session. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections
    log-error-verbosity -> (struct)
      Controls the amount of detail written in the server log for each message that is logged. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity
    log-hostname -> (boolean)
      By default, connection log messages only show the IP address of the connecting host. Turning on this option causes logging of the host name as well. Note that depending on your host name resolution setup this might impose a non-negligible performance penalty. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname
    log-min-duration-statement -> (integer)
      Logs the statement and its duration on a single log line if its duration is greater than or equal to the specified number of milliseconds. Setting this to 0 will print all statements and their durations. -1 deactivates the feature. For example, if you set it to 250 then all SQL statements that run 250ms or longer will be logged. Enabling this option can be useful in tracking down unoptimized queries in your applications. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement
    log-min-messages -> (struct)
      Controls which message levels are written to the server log. Each level includes all the levels that follow it. The later the level, the fewer messages are sent to the log. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages
    log-statement -> (struct)
      Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl
    log-statement-stats -> (boolean)
      For each query, write total performance statistics of the query parser, planner, and executor to the server log. This is a crude profiling instrument. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats
    master-shared-buffers -> (integer)
      Sets the amount of memory a Greenplum Database master instance uses for shared memory buffers. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers
    max-connections -> (integer)
      Maximum number of inbound connections on master segment
    max-locks-per-transaction -> (integer)
      The shared lock table is created with room to describe locks on max_locks_per_transaction * (max_connections + max_prepared_transactions) objects, so no more than this many distinct objects can be locked at any one time. This is not a hard limit on the number of locks taken by any one transaction, but rather a maximum average value. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#max_locks_per_transaction
    max-prepared-transactions -> (integer)
      Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html
    max-slot-wal-keep-size -> (integer)
      Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html
    max-statement-mem -> (integer)
      Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)
    runaway-detector-activation-percent -> (integer)
      Percent of utilized Greenplum Database vmem that triggers the termination of queries. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#runaway_detector_activation_percent
    segment-shared-buffers -> (integer)
      Sets the amount of memory a Greenplum Database segment instance uses for shared memory buffers. https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers
``` ||
|| `--deletion-protection` | Determines whether the cluster is protected from being deleted. ||
|| `--description` | `string`

Description of the Greenplum® cluster. ||
|| `--environment` | `enum`

Deployment environment of the Greenplum® cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the Greenplum® cluster in. ||
|| `--host-group-ids` | `[]string`

Host groups to place VMs of the cluster in. ||
|| `--labels` | `map<string><string>`

Custom labels for the Greenplum® cluster as 'key:value' pairs. For example, '"project":"mvp"' or '"source":"dictionary"'. ||
|| `--logging` | `shorthand/json`

Cloud logging configuration

Shorthand Syntax:

```hcl
{
  command-center-enabled = boolean,
  destination = folder-id=string | log-group-id=string,
  enabled = boolean,
  greenplum-enabled = boolean,
  pooler-enabled = boolean
}
```

JSON Syntax:

```json
{
  "command-center-enabled": "boolean",
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "enabled": "boolean",
  "greenplum-enabled": "boolean",
  "pooler-enabled": "boolean"
}
```

Fields:

```
command-center-enabled -> (boolean)
  send Yandex Command Center logs
enabled -> (boolean)
greenplum-enabled -> (boolean)
  send Greenplum logs
pooler-enabled -> (boolean)
  send Pooler logs
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  folder-id -> (string)
  log-group-id -> (string)
``` ||
|| `--maintenance-window` | `shorthand/json`

A Greenplum® cluster maintenance window. Should be defined by either one of the two options.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
    An any-time maintenance window.
  weekly-maintenance-window -> (struct)
    A weekly maintenance window.
    day -> (struct)
      Day of the week.
    hour -> (integer)
      Hour of the day in the UTC timezone.
``` ||
|| `--master-config` | `shorthand/json`

Configuration of the Greenplum® master subcluster.

Shorthand Syntax:

```hcl
{
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  }
}
```

JSON Syntax:

```json
{
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  }
}
```

Fields:

```
resources -> (struct)
  Resources allocated to Greenplum® master subcluster hosts.
  disk-size -> (integer)
    Volume of the storage used by the host, in bytes.
  disk-type-id -> (string)
    Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
  resource-preset-id -> (string)
    ID of the preset for computational resources allocated to a host. Available presets are listed in the documentation.
``` ||
|| `--master-host-count` | `int`

Number of hosts in the master subcluster. ||
|| `--master-host-group-ids` | `[]string`

Host groups hosting VMs of the master subcluster. ||
|| `--name` | `string`

Name of the Greenplum® cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--security-group-ids` | `[]string`

User security groups. ||
|| `--segment-config` | `shorthand/json`

Configuration of the Greenplum® segment subcluster.

Shorthand Syntax:

```hcl
{
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  }
}
```

JSON Syntax:

```json
{
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  }
}
```

Fields:

```
resources -> (struct)
  Resources allocated to Greenplum® segment subcluster hosts.
  disk-size -> (integer)
    Volume of the storage used by the host, in bytes.
  disk-type-id -> (string)
    Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
  resource-preset-id -> (string)
    ID of the preset for computational resources allocated to a host. Available presets are listed in the documentation.
``` ||
|| `--segment-host-count` | `int`

Number of hosts in the segment subcluster. ||
|| `--segment-host-group-ids` | `[]string`

Host groups hosting VMs of the segment subcluster. ||
|| `--segment-in-host` | `int`

Number of segments per host. ||
|| `--service-account-id` | `string`

ID of the service account used for access Yandex Cloud resources. ||
|| `--user-name` | `string`

Owner user name. ||
|| `--user-password` | `string`

Owner user password. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#