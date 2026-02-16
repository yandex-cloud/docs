---
editable: false
sourcePath: en/_cli-ref/cli-ref/metadata-hub/cli-ref/connection-manager/connection/update/index.md
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