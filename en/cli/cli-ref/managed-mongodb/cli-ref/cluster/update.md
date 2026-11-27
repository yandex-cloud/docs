---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-mongodb/cli-ref/cluster/update/
alternate:
  - href: en/cli/cli-ref/managed-mongodb/cli-ref/cluster/update.md
    type: text/markdown
    title: Markdown version
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
|| `--maintenance-window-slot` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Weekly maintenance slot. Can be repeated; replaces the complete schedule. Cannot be combined with --maintenance-anytime or --maintenance-window. Example: day=MONDAY,start-time=01:30:00,duration=1h,allow-temporary-unavailability=true

Possible property names:

- `day`: Day of week: MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY. Values: 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'

- `start-time`: Start time in UTC, in HH:MM:SS format.

- `duration`: Positive slot duration, for example 1h or 90m.

- `allow-temporary-unavailability`: Allow temporary unavailability during this slot. ||
|| `--maintenance-anytime` | Allow maintenance at any time. Replaces the complete schedule. Cannot be combined with --maintenance-window-slot or --maintenance-window. ||
|| `--description` | `string`

New description for the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--feature-compatibility-version` | `string`

When set, minimal DB version possible (can not be downgraded). Supported value: 5.0, 6.0, 7.0 ||
|| `--security-group-ids` | `[]string`

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
|| `--autocompact` | Enable or disable autocompact ||
|| `--autocompact-bloat-percent` | `float`

Percent of free space required before autocompact is triggered ||
|| `--autocompact-target-free-space` | `int`

Target free space in megabytes ||
|| `--autocompact-compaction-type` | `string`

Compaction type Values: 'compaction-type-ignore-primary', 'compaction-type-switch-primary' ||
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