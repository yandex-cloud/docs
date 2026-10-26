[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [managed-greenplum](../../index.md) > [v0](../index.md) > [cluster](index.md) > create

# yc managed-greenplum v0 cluster create

Create a Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum v0 cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Cluster name. ||
|| `--description` | `string`

Cluster description. ||
|| `--environment` | `string`

Cluster environment. Values: production, prestable. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--master-host-count` | `int`

Master host count. Values: 1, 2. Default is 2. ||
|| `--segment-host-count` | `int`

Segment host count. Default is 2. ||
|| `--segment-in-host` | `int`

Numbers of segments in host. ||
|| `--user-name` | `string`

Cluster owner user name. ||
|| `--user-password` | `string`

Owner user password. Must be 8-128 characters long. ||
|| `--master-config` | `KEY=VALUE[,KEY=VALUE...]`

Descriptions of master config for Greenplum cluster. ||
|| `--segment-config` | `KEY=VALUE[,KEY=VALUE...]`

Descriptions of segment config for Greenplum cluster. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. ||
|| `--host-group-ids` | `[]string`

A list of host groups for Greenplum cluster. ||
|| `--master-host-group-ids` | `[]string`

A list of host groups for Greenplum master subcluster. ||
|| `--segment-host-group-ids` | `[]string`

A list of host groups for Greenplum segment subcluster. ||
|| `--security-group-ids` | `[]string`

A list of security groups for the Greenplum cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--cloud-storage` | `KEY=VALUE[,KEY=VALUE...]`

Descriptions of cloud storage for Greenplum cluster. ||
|| `--service-account` | `string`

ID of the service account used for access Yandex Cloud resources. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. ||
|| `--datalens-access` | Allow access for DataLens. ||
|| `--websql-access` | Allow access for Web SQL. ||
|| `--datatransfer-access` | Allow access for DataTransfer. ||
|| `--yandexquery-access` | Allow access for Yandex Query. ||
|| `--trino-access` | Allow access for Trino (including TLS for gpfdist). ||
|| `--version` | `string`

Version of Greenplum or Cloudberry used in the cluster. ||
|| `--zone-id` | `string`

ID of the availability zone where the host resides. ||
|| `--subnet-id` | `string`

ID of the subnet that the host should be created in. ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retention time in days of automated backups ||
|| `--assign-public-ip` | Whether the host should get a public IP address. ||
|| `--maintenance-window` | `KEY=VALUE[,KEY=VALUE...]`

Maintenance window settings ||
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