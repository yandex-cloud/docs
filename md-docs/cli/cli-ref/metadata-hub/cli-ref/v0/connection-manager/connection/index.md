[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник (англ.)](../../../../../index.md) > [metadata-hub](../../../index.md) > [v0](../../index.md) > [connection-manager](../index.md) > connection > Overview

# yc metadata-hub v0 connection-manager connection

Manage connections

#### Command Usage

Syntax:

`yc metadata-hub v0 connection-manager connection <group|command>`

#### Command Tree

- [yc metadata-hub v0 connection-manager connection delete](delete.md) — Delete connection

- [yc metadata-hub v0 connection-manager connection get](get.md) — Get connection

- [yc metadata-hub v0 connection-manager connection list](list.md) — List connections

- [yc metadata-hub v0 connection-manager connection list-operations](list-operations.md) — List operations for the specified connection

- [yc metadata-hub v0 connection-manager connection resolve-cluster](resolve-cluster.md) — Resolve cluster

- [yc metadata-hub v0 connection-manager connection create](create/index.md) — Create connection

  - [yc metadata-hub v0 connection-manager connection create clickhouse](create/clickhouse.md) — Create ClickHouse connection

  - [yc metadata-hub v0 connection-manager connection create greenplum](create/greenplum.md) — Create Greenplum connection

  - [yc metadata-hub v0 connection-manager connection create kafka](create/kafka.md) — Create Kafka connection

  - [yc metadata-hub v0 connection-manager connection create mongodb](create/mongodb.md) — Create MongoDB connection

  - [yc metadata-hub v0 connection-manager connection create mysql](create/mysql.md) — Create MySQL connection

  - [yc metadata-hub v0 connection-manager connection create opensearch](create/opensearch.md) — Create OpenSearch connection

  - [yc metadata-hub v0 connection-manager connection create postgresql](create/postgresql.md) — Create PostgreSQL connection

  - [yc metadata-hub v0 connection-manager connection create redis](create/redis.md) — Create Redis connection

  - [yc metadata-hub v0 connection-manager connection create trino](create/trino.md) — Create Trino connection

  - [yc metadata-hub v0 connection-manager connection create valkey](create/valkey.md) — Create Valkey connection

- [yc metadata-hub v0 connection-manager connection update](update/index.md) — Update connection

  - [yc metadata-hub v0 connection-manager connection update clickhouse](update/clickhouse.md) — Update ClickHouse connection

  - [yc metadata-hub v0 connection-manager connection update greenplum](update/greenplum.md) — Update Greenplum connection

  - [yc metadata-hub v0 connection-manager connection update kafka](update/kafka.md) — Update Kafka connection

  - [yc metadata-hub v0 connection-manager connection update mongodb](update/mongodb.md) — Update MongoDB connection

  - [yc metadata-hub v0 connection-manager connection update mysql](update/mysql.md) — Update MySQL connection

  - [yc metadata-hub v0 connection-manager connection update opensearch](update/opensearch.md) — Update OpenSearch connection

  - [yc metadata-hub v0 connection-manager connection update postgresql](update/postgresql.md) — Update PostgreSQL connection

  - [yc metadata-hub v0 connection-manager connection update redis](update/redis.md) — Update Redis connection

  - [yc metadata-hub v0 connection-manager connection update trino](update/trino.md) — Update Trino connection

  - [yc metadata-hub v0 connection-manager connection update valkey](update/valkey.md) — Update Valkey connection

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