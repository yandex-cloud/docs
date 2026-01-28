---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-redis/cli-ref/cluster/update.md
---

# yc managed-redis cluster update

Update the specified Redis cluster

#### Command Usage

Syntax:

`yc managed-redis cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Redis cluster id. ||
|| `--name` | `string`

Redis cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the cluster ||
|| `--description` | `string`

Cluster description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the Redis cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--persistence-mode` | `string`

Persistence mode for Redis cluster (ON, OFF or ON_REPLICAS). ||
|| `--force` | Override persistence turning OFF. ||
|| `--announce-hostnames` | Enable announce hostnames for Redis cluster. ||
|| `--auth-sentinel` | Allows to use ACL users to auth in sentinel ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `disk-size-limit`: Set disk size limit in GB

- `planned-usage-threshold`: Planned usage threshold

- `emergency-usage-threshold`: Emergency usage threshold ||
|| `--valkey-modules` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Valkey modules settings

Possible property names:

- `enable-valkey-search`: Enable valkey-search module

- `valkey-search-reader-threads`: Controls the amount of threads executing valkey-search queries

- `valkey-search-writer-threads`: Controls the amount of threads processing valkey-search index mutations

- `enable-valkey-json`: Enable valkey-json module

- `enable-valkey-bloom`: Enable valkey-bloom module ||
|| `--redis-version` | `string`

Version of Redis used in the cluster. Values: 7.2 ||
|| `--resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--disk-type-id` | `string`

Disk type id (e.g., network-ssd). ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retain period of automatically created backup in days. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
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