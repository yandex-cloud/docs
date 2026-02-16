---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/cluster/update.md
---

# yc managed-greenplum cluster update

Update the specified Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Greenplum cluster id. ||
|| `--name` | `string`

Greenplum cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--description` | `string`

Cluster description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. ||
|| `--new-name` | `string`

New name for the Greenplum cluster ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--user-password` | `string`

Owner user password. Must be 8-128 characters long. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the Greenplum cluster. ||
|| `--master-config` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of master config resources for Greenplum cluster.

Possible property names:

- `resource-id`: ID of the preset for computational resources available on the host.

- `disk-size`: Volume of the storage available on the host in GB. ||
|| `--segment-config` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of segment config resources for Greenplum cluster.

Possible property names:

- `resource-id`: ID of the preset for computational resources available on the host.

- `disk-size`: Volume of the storage available on the host in GB. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--cloud-storage` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of cloud storage for Greenplum cluster.

Possible property names:

- `enabled`: Enables cloud storage. ||
|| `--service-account` | `string`

ID of the service account used for access Yandex Cloud resources. ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
|| `--datalens-access` | Allow access for DataLens. ||
|| `--websql-access` | Allow access for Web SQL. ||
|| `--datatransfer-access` | Allow access for DataTransfer. ||
|| `--yandexquery-access` | Allow access for Yandex Query. ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retention time in days of automated backups ||
|| `--assign-public-ip` | Whether the host should get a public IP address. ||
|| `--connection-pooling-mode` | `string`

Connection pooler pooling mode Values: 'session', 'transaction' ||
|| `--connection-pooling-size` | `int`

Connection pooler size ||
|| `--connection-pooling-client-idle-timeout` | `int`

Connection pooler client idle timeout ||
|| `--connection-pooling-idle-in-transaction-timeout` | `int`

Connection pooler idle in transaction timeout ||
|| `--pxf-connection-timeout` | `int`

Timeout for pxf connections ||
|| `--pxf-upload-timeout` | `int`

Timeout for uploading pxf connections ||
|| `--pxf-max-threads` | `int`

The maximum number of PXF tomcat threads. ||
|| `--pxf-pool-allow-core-thread-timeout` | Identifies whether or not core streaming threads are allowed to time out. ||
|| `--pxf-poll-core-size` | `int`

The number of core streaming threads. ||
|| `--pxf-pool-queue-capacity` | `int`

The capacity of the core streaming thread pool queue. ||
|| `--pxf-pool-max-size` | `int`

The maximum allowed number of core streaming threads. ||
|| `--pxf-xmx` | `byteSize`

Max jvm memory ||
|| `--pxf-xms` | `byteSize`

Starting jvm memory ||
|| `--analyze-and-vacuum` | ANALYZE
Configuration for ANALYZE and `VACUUM` background operations.

Possible property names:

- `start_time`: 
- `Time (HH:MM) in UTC time zone to start `ANALYZE` and `VACUUM` operations.`: 
- `analyze_timeout`: 
- `Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.`: 
- `vacuum_timeout`: 
- `Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.`:  ||
|| `--query-killer-idle` | `idle`

Configuration of script that kills long running queries that are in idle state.

Possible property names:

- `enable`: Enables query killer for this type of queries.

- `max_age`: Maximum duration for this type of queries (in seconds).

- `ignore_users`: Ignore these users when considering queries to terminate ||
|| `--query-killer-idle-in-transaction` | `idle`

in transaction
Configuration of script that kills long running queries that are in idle in transaction state.

Possible property names:

- `enable`: 
- `Enables query killer for this type of queries.`: 
- `max_age`: 
- `Maximum duration for this type of queries (in seconds).`: 
- `ignore_users`: 
- `Ignore these users when considering queries to terminate`:  ||
|| `--query-killer-long-running` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configuration of script that kills long running queries (in any state).

Possible property names:

- `enable`: Enables query killer for this type of queries.

- `max_age`: Maximum duration for this type of queries (in seconds).

- `ignore_users`: Ignore these users when considering queries to terminate ||
|| `--log-enabled` | Whether logs generated by the Greenplum components are delivered to Cloud Logging. ||
|| `--log-folder-id` | `string`

ID of the folder to store logs in default log_group. ||
|| `--log-group-id` | `string`

ID of the log_group to store logs in. ||
|| `--log-command-center-enabled` | Whether logs generated by the Command Center are delivered to Cloud Logging. ||
|| `--log-greenplum-enabled` | Whether logs generated by the Greenplum are delivered to Cloud Logging. ||
|| `--log-pooler-enabled` | Whether logs generated by the Pooler are delivered to Cloud Logging. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#