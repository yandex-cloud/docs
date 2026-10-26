---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-sharded-postgresql/cli-ref/cluster/restore/
---

# yc managed-sharded-postgresql cluster restore

Restore Sharded PostgreSQL cluster

#### Command Usage

Syntax:

`yc managed-sharded-postgresql cluster restore [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backup-id` | `string`

ID of the backup to create a cluster from. ||
|| `--time` | `timestamp`

Timestamp in RFC3339 of the moment to which the Sharded PostgreSQL cluster should be restored. ||
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

Individual configurations for hosts that should be created for the Sharded PostgreSQL cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Whether the host should get a public IP address on creation.

- `type`: Type of the host Values: 'router', 'coordinator', 'infra', 'postgresql', 'external-postgresql', 'mdb-postgresql' ||
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
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--security-group-ids` | `[]string`

A list of security groups for the Sharded PostgreSQL cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
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