---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-clickhouse/cli-ref/shard-groups/update/
---

# yc managed-clickhouse shard-groups update

Modify configuration or attributes of a ClickHouse shard group.

#### Command Usage

Syntax:

`yc managed-clickhouse shard-groups update <SHARD-GROUP-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster. ||
|| `--cluster-name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

Shard group name. ||
|| `--description` | `string`

Description of the shard group. ||
|| `--shards` | `value[,value]`

Shards that should be in group. ||
|| `--external-shard` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

External shard configuration. Each flag invocation adds one external shard. Replaces the entire external_shards list.

Possible property names:

- `name`: External shard name. (required)

- `weight`: Weight of the external shard; an integer. ||
|| `--external-shard-replica` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

External shard replica configuration. Each flag invocation adds one replica to the shard identified by shard=... .

Possible property names:

- `shard`: Name of the external shard that the replica belongs to. (required)

- `host`: Replica host FQDN or IP address. (required)

- `port`: Replica port.

- `secure`: Use TLS for replica connection.

- `user`: Replica user name.

- `password`: Replica user password.

- `priority`: Replica priority. ||
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