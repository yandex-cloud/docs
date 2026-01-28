---
editable: false
sourcePath: en/_cli-ref/cli-ref/metadata-hub/cli-ref/connection-manager/connection/create/index.md
---

# yc metadata-hub connection-manager connection create

Create connection

#### Command Usage

Syntax:

`yc metadata-hub connection-manager connection create <command>`

#### Command Tree

- [yc metadata-hub connection-manager connection create clickhouse](clickhouse.md) — Create ClickHouse connection

- [yc metadata-hub connection-manager connection create greenplum](greenplum.md) — Create Greenplum connection

- [yc metadata-hub connection-manager connection create kafka](kafka.md) — Create Kafka connection

- [yc metadata-hub connection-manager connection create mongodb](mongodb.md) — Create MongoDB connection

- [yc metadata-hub connection-manager connection create mysql](mysql.md) — Create MySQL connection

- [yc metadata-hub connection-manager connection create opensearch](opensearch.md) — Create OpenSearch connection

- [yc metadata-hub connection-manager connection create postgresql](postgresql.md) — Create PostgreSQL connection

- [yc metadata-hub connection-manager connection create redis](redis.md) — Create Redis connection

- [yc metadata-hub connection-manager connection create trino](trino.md) — Create Trino connection

- [yc metadata-hub connection-manager connection create valkey](valkey.md) — Create Valkey connection

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