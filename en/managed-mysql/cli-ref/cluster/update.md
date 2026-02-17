---
editable: false
---

# yc managed-mysql cluster update

Update the specified MySQL cluster

#### Command Usage

Syntax:

`yc managed-mysql cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

MySQL cluster id. ||
|| `--name` | `string`

MySQL cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the MySQL cluster ||
|| `--description` | `string`

Cluster description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the MySQL cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--mysql-version` | `string`

Version of MYSQL used in the cluster ||
|| `--resource-preset` | `string`

ID of the preset for computational resources available to a host ||
|| `--disk-size` | `byteSize`

Volume of the storage available to a host in GB ||
|| `--disk-type` | `string`

Type of the storage environment for a host ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retention policy of automated backups. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--yandexquery-access` | Allow access for YandexQuery ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
|| `--performance-diagnostics` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Performance diagnostics settings

Possible property names:

- `enabled`: Enable or disable performance diagnostics

- `sessions-sampling-interval`: my_stat_activity sampling interval

- `statements-sampling-interval`: my_stat_statements sampling interval ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `disk-size-limit`: Set disk size limit

- `planned-usage-threshold`: Planned usage threshold

- `emergency-usage-threshold`: Emergency usage threshold ||
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