---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/metadata-hub/cli-ref/connection-manager/connection/update/
---

# yc metadata-hub connection-manager connection update

Update connection

#### Command Usage

Syntax:

`yc metadata-hub connection-manager connection update <command>`

#### Command Tree

- [yc metadata-hub connection-manager connection update clickhouse](clickhouse.md) — Update ClickHouse connection

- [yc metadata-hub connection-manager connection update greenplum](greenplum.md) — Update Greenplum connection

- [yc metadata-hub connection-manager connection update kafka](kafka.md) — Update Kafka connection

- [yc metadata-hub connection-manager connection update mongodb](mongodb.md) — Update MongoDB connection

- [yc metadata-hub connection-manager connection update mysql](mysql.md) — Update MySQL connection

- [yc metadata-hub connection-manager connection update opensearch](opensearch.md) — Update OpenSearch connection

- [yc metadata-hub connection-manager connection update postgresql](postgresql.md) — Update PostgreSQL connection

- [yc metadata-hub connection-manager connection update redis](redis.md) — Update Redis connection

- [yc metadata-hub connection-manager connection update trino](trino.md) — Update Trino connection

- [yc metadata-hub connection-manager connection update valkey](valkey.md) — Update Valkey connection

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