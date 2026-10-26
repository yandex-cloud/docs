[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Справочник CLI (англ.)](../index.md) > [cluster](index.md) > update

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
|| `--description` | `string`

Cluster description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. ||
|| `--new-name` | `string`

New name for the Greenplum cluster ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--user-password` | `string`

Owner user password. Must be 8-128 characters long. ||
|| `--security-group-ids` | `[]string`

A list of security groups for the Greenplum cluster. ||
|| `--master-config` | `KEY=VALUE[,KEY=VALUE...]`

Descriptions of master config resources for Greenplum cluster. ||
|| `--segment-config` | `KEY=VALUE[,KEY=VALUE...]`

Descriptions of segment config resources for Greenplum cluster. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--cloud-storage` | `KEY=VALUE[,KEY=VALUE...]`

Descriptions of cloud storage for Greenplum cluster. ||
|| `--service-account` | `string`

ID of the service account used for access Yandex Cloud resources. ||
|| `--maintenance-window` | `KEY=VALUE[,KEY=VALUE...]`

Maintenance window settings ||
|| `--datalens-access` | Allow access for DataLens. ||
|| `--websql-access` | Allow access for Web SQL. ||
|| `--datatransfer-access` | Allow access for DataTransfer. ||
|| `--yandexquery-access` | Allow access for Yandex Query. ||
|| `--trino-access` | Allow access for Trino (including TLS for gpfdist). ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retention time in days of automated backups ||
|| `--assign-public-ip` | Whether the host should get a public IP address. ||
|| `--connection-pooling-mode` | `string`

Connection pooler pooling mode ||
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
|| `--analyze-and-vacuum` | `KEY=VALUE[,KEY=VALUE...]`

Configuration for ANALYZE and VACUUM background operations. ||
|| `--query-killer-idle` | `KEY=VALUE[,KEY=VALUE...]`

Configuration of idle query killer. ||
|| `--query-killer-idle-in-transaction` | `KEY=VALUE[,KEY=VALUE...]`

Configuration of idle in transaction query killer. ||
|| `--query-killer-long-running` | `KEY=VALUE[,KEY=VALUE...]`

Configuration of long running query killer. ||
|| `--log-enabled` | Whether logs are delivered to Cloud Logging. ||
|| `--log-folder-id` | `string`

Folder ID for logs. ||
|| `--log-group-id` | `string`

Log group ID. ||
|| `--log-command-center-enabled` | Deliver Command Center logs. ||
|| `--log-greenplum-enabled` | Deliver Greenplum logs. ||
|| `--log-pooler-enabled` | Deliver Pooler logs. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#