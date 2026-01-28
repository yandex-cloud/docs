---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-postgresql/cli-ref/cluster/create.md
---

# yc managed-postgresql cluster create

Create PostgreSQL cluster

#### Command Usage

Syntax:

`yc managed-postgresql cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

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

Individual configurations for hosts that should be created for the PostgresSQL cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Whether the host should get a public IP address on creation.

- `replication-source`: Host name of the host to be used as the replication source (for cascading replication).

- `priority`: Priority of the host as a replica. ||
|| `--user` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of database users to be created in the PostgresSQL cluster.

Possible property names:

- `name`: Name of the PostgresSQL user.

- `password`: Password of the PostgresSQL user.

- `generate-password`: Generate password using Connection Manager.

- `permission`: Permission for PostgresSQL user.

- `conn-limit`: Number of connections available to the user.

- `lock-timeout`: Lock timeout in milliseconds.

- `log-min-duration-statement`: Log minimal duration statement in milliseconds.

- `temp-file-limit`: Temporary file limit in bytes.

- `default-transaction-isolation`: Default transaction isolation. Values: 'transaction-isolation-read-uncommitted', 'transaction-isolation-read-committed', 'transaction-isolation-repeatable-read', 'transaction-isolation-serializable'

- `synchronous-commit`: Synchronous commit. Values: 'synchronous-commit-on', 'synchronous-commit-off', 'synchronous-commit-local', 'synchronous-commit-remote-write', 'synchronous-commit-remote-apply'

- `log-statement`: Log statement. Values: 'log-statement-none', 'log-statement-ddl', 'log-statement-mod', 'log-statement-all'

- `statement-timeout`: Statement timeout in milliseconds.

- `idle-in-transaction-session-timeout`: Idle in transaction session timeout in milliseconds.

- `wal-sender-timeout`: WAL sender timeout in milliseconds.

- `pgaudit.log`: Enable audit events for user ||
|| `--database` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of databases to be created in the PostgresSQL cluster.

Possible property names:

- `name`: Name of the PostgresSQL database.

- `owner`: Name of the user to be assigned as the owner of the database.

- `lc-collate`: POSIX locale for string sorting order.

- `lc-ctype`: POSIX locale for character classification. ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--serverless-access` | Allow access for Serverless ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--yandexquery-access` | Allow access for Yandex Query ||
|| `--postgresql-version` | `string`

Version of PostgreSQL used in the cluster. Values: 16, 15, 14, 13, 12, 11, 10, 14-1c, 13-1c, 12-1c, 11-1c, 10-1c ||
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

A list of security groups for the PostgreSQL cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--host-group-ids` | `value[,value]`

A list of host groups to place VMs of cluster on. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. ||
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