[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for PostgreSQL](../../index.md) > [Справочник CLI (англ.)](../index.md) > [cluster](index.md) > restore

# yc managed-postgresql cluster restore

Restore PostgreSQL cluster

#### Command Usage

Syntax:

`yc managed-postgresql cluster restore [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backup-id` | `string`

ID of the backup to create a cluster from. ||
|| `--time` | `timestamp`

Timestamp in RFC3339 of the moment to which the PostgreSQL cluster should be restored. ||
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

Individual configurations for hosts that should be created for the PostgresSQL cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Whether the host should get a public IP address on creation.

- `replication-source`: Host name of the host to be used as the replication source (for cascading replication).

- `priority`: Priority of the host as a replica. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--serverless-access` | Allow access for Serverless ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--yandexquery-access` | Allow access for Yandex Query ||
|| `--postgresql-version` | `string`

Version of PostgreSQL used in the cluster. Values: 19, 18, 17, 16, 15, 14, 19-1c, 18-1c, 17-1c, 16-1c, 15-1c, 14-1c ||
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
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the PostgreSQL cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--host-group-ids` | `value[,value]`

A list of host groups to place VMs of cluster on. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. Empty input will remove the use of encryption. ||
|| `--maintenance-window-slot` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Weekly maintenance slot. Can be repeated; replaces the complete schedule. Cannot be combined with --maintenance-anytime or --maintenance-window. Example: day=MONDAY,start-time=01:30:00,duration=1h,allow-temporary-unavailability=true

Possible property names:

- `day`: Day of week: MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY. Values: 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'

- `start-time`: Start time in UTC, in HH:MM:SS format.

- `duration`: Positive slot duration, for example 1h or 90m.

- `allow-temporary-unavailability`: Allow temporary unavailability during this slot. ||
|| `--maintenance-anytime` | Allow maintenance at any time. Replaces the complete schedule. Cannot be combined with --maintenance-window-slot or --maintenance-window. ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `disk-size-limit`: Set disk size limit

- `planned-usage-threshold`: Planned usage threshold

- `emergency-usage-threshold`: Emergency usage threshold ||
|| `--connection-manager` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Connection Manager cluster integration settings

Possible property names:

- `connections-folder-id`: ID of the folder where connections for the cluster are created

- `secrets-folder-id`: ID of the folder where connection secrets are created. ||
|| `--managed-repack` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Managed pg_repack cluster settings

Possible property names:

- `enabled`: Enable or disable managed pg_repack for the cluster ||
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