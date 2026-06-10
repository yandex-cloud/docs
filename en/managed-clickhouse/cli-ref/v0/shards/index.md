---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-clickhouse/cli-ref/v0/shards/
---

# yc managed-clickhouse v0 shards

Manage shards in a ClickHouse cluster.

#### Command Usage

Syntax:

`yc managed-clickhouse shards <command>`

Aliases:

- `shard`

#### Command Tree

- [yc managed-clickhouse v0 shards add](add.md) — Create new shard(s) for the cluster in the specified availability zones.

- [yc managed-clickhouse v0 shards delete](delete.md) — Delete a shard.

- [yc managed-clickhouse v0 shards get](get.md) — Get information about a shard in a ClickHouse cluster.

- [yc managed-clickhouse v0 shards list](list.md) — List shards for a ClickHouse cluster.

- [yc managed-clickhouse v0 shards update](update.md) — Modify configuration or attributes of a ClickHouse shard.

- [yc managed-clickhouse v0 shards update-config](update-config.md) — Update the configurationg for a shard.

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