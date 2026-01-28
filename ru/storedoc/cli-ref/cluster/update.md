---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-mongodb/cli-ref/cluster/update.md
---

# yc managed-mongodb cluster update

Modify configuration or attributes of a MongoDB cluster.

#### Command Usage

Syntax:

`yc managed-mongodb cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the MongoDB cluster. ||
|| `--name` | `string`

Name of the MongoDB cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
|| `--description` | `string`

New description for the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--feature-compatibility-version` | `string`

When set, minimal DB version possible (can not be downgraded). Supported value: 5.0, 6.0, 7.0 ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the MongoDB cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `mongod-disk-size-limit`: Set disk size limit for mongod in GB

- `mongod-planned-usage-threshold`: Planned usage threshold mongod

- `mongod-emergency-usage-threshold`: Emergency usage threshold mongod

- `mongocfg-disk-size-limit`: Set disk size limit for mongocfg in GB

- `mongocfg-planned-usage-threshold`: Planned usage threshold mongocfg

- `mongocfg-emergency-usage-threshold`: Emergency usage threshold mongocfg

- `mongoinfra-disk-size-limit`: Set disk size limit for mongoinfra in GB

- `mongoinfra-planned-usage-threshold`: Planned usage threshold mongoinfra

- `mongoinfra-emergency-usage-threshold`: Emergency usage threshold mongoinfra

- `mongos-disk-size-limit`: Set disk size limit for mongos in GB

- `mongos-planned-usage-threshold`: Planned usage threshold mongos

- `mongos-emergency-usage-threshold`: Emergency usage threshold mongos ||
|| `--mongodb-version` | `string`

Version of MongoDB used by the cluster. Supported value: 5.0, 6.0, 7.0 ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retain period of automatically created backup in days. ||
|| `--performance-diagnostics` | Enable or disable performance diagnostics ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--mongod-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongod-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongod-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--mongocfg-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongocfg-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongocfg-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--mongos-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongos-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongos-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--mongoinfra-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongoinfra-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongoinfra-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
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