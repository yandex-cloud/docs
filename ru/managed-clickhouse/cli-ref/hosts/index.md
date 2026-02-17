---
editable: false
---

# yc managed-clickhouse hosts

Manage hosts of a ClickHouse cluster.

#### Command Usage

Syntax:

`yc managed-clickhouse hosts <command>`

Aliases:

- `host`

#### Command Tree

- [yc managed-clickhouse hosts add](add.md) — Add new hosts to the cluster in specified availability zones.

- [yc managed-clickhouse hosts delete](delete.md) — Remove specified hosts from the cluster.

- [yc managed-clickhouse hosts list](list.md) — List hosts for a ClickHouse cluster.

- [yc managed-clickhouse hosts restart](restart.md) — Restart specified hosts of the cluster.

- [yc managed-clickhouse hosts update](update.md) — Update the specified hosts

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