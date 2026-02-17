---
editable: false
---

# yc managed-mysql cluster create

Create MySQL cluster

#### Command Usage

Syntax:

`yc managed-mysql cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

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
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for hosts that should be created for the MySQL cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Whether the host should get a public IP address on creation.

- `replication-source`: Name of the host to be used as the replication source for cascaded replication.

- `backup-priority`: Priority of the host as a backup source.

- `priority`: Host master promotion priority. ||
|| `--user` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of database users to be created in the MySQL cluster.

Possible property names:

- `name`: Name of the MySQL user.

- `password`: Password of the MySQL user.

- `generate-password`: Generate password using Connection Manager. ||
|| `--database` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of databases to be created in the MySQL cluster.

Possible property names:

- `name`: Name of the MySQL database. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--yandexquery-access` | Allow access for YandexQuery ||
|| `--mysql-version` | `string`

Version of MYSQL used in the cluster. Values: 8.0, 5.7 ||
|| `--resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--disk-type` | `string`

Type of the storage environment for the host. ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retention policy of automated backups. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the MySQL cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--host-group-ids` | `value[,value]`

A list of host groups to place VMs of cluster on. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. ||
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
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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