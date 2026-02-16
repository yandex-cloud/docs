---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-trino/cli-ref/catalog/create/index.md
---

# yc managed-trino catalog create

Create Trino catalog

#### Command Usage

Syntax:

`yc managed-trino catalog create <command>`

#### Command Tree

- [yc managed-trino catalog create clickhouse](clickhouse.md) — Create ClickHouse catalog

- [yc managed-trino catalog create delta-lake](delta-lake.md) — Create Delta Lake catalog

- [yc managed-trino catalog create greenplum](greenplum.md) — Create Greenplum catalog

- [yc managed-trino catalog create hive](hive.md) — Create Hive catalog

- [yc managed-trino catalog create hudi](hudi.md) — Create Hudi catalog

- [yc managed-trino catalog create iceberg](iceberg.md) — Create Iceberg catalog

- [yc managed-trino catalog create mysql](mysql.md) — Create MySQL catalog

- [yc managed-trino catalog create oracle](oracle.md) — Create Oracle catalog

- [yc managed-trino catalog create postgresql](postgresql.md) — Create PostgreSQL catalog

- [yc managed-trino catalog create sqlserver](sqlserver.md) — Create MS SQL Server catalog

- [yc managed-trino catalog create tpcds](tpcds.md) — Create TPC-DS catalog

- [yc managed-trino catalog create tpch](tpch.md) — Create TPC-H catalog

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