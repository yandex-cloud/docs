---
editable: false
---

# yc managed-sharded-postgresql cluster update

Update the specified Sharded PostgreSQL cluster

#### Command Usage

Syntax:

`yc managed-sharded-postgresql cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Sharded PostgreSQL cluster id. ||
|| `--name` | `string`

Sharded PostgreSQL cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the cluster ||
|| `--description` | `string`

Cluster description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the Sharded PostgreSQL cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--router-resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--router-disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--router-disk-type` | `string`

Type of the storage environment for the host. ||
|| `--coordinator-resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--coordinator-disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--coordinator-disk-type` | `string`

Type of the storage environment for the host. ||
|| `--infra-resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--infra-disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--infra-disk-type` | `string`

Type of the storage environment for the host. ||
|| `--postgresql-resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--postgresql-disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--postgresql-disk-type` | `string`

Type of the storage environment for the host. ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retention policy of automated backups. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--serverless-access` | Allow access for Serverless ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
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