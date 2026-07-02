[Документация Yandex Cloud](../../../../../index.md) > [Yandex Managed Service for Trino](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [v0](../../index.md) > [catalog](../index.md) > create > Overview

# yc managed-trino v0 catalog create

Create Trino catalog

#### Command Usage

Syntax:

`yc managed-trino catalog create <command>`

#### Command Tree

- [yc managed-trino v0 catalog create clickhouse](clickhouse.md) — Create ClickHouse catalog

- [yc managed-trino v0 catalog create delta-lake](delta-lake.md) — Create Delta Lake catalog

- [yc managed-trino v0 catalog create greenplum](greenplum.md) — Create Greenplum catalog

- [yc managed-trino v0 catalog create hive](hive.md) — Create Hive catalog

- [yc managed-trino v0 catalog create hudi](hudi.md) — Create Hudi catalog

- [yc managed-trino v0 catalog create iceberg](iceberg.md) — Create Iceberg catalog

- [yc managed-trino v0 catalog create mysql](mysql.md) — Create MySQL catalog

- [yc managed-trino v0 catalog create oracle](oracle.md) — Create Oracle catalog

- [yc managed-trino v0 catalog create postgresql](postgresql.md) — Create PostgreSQL catalog

- [yc managed-trino v0 catalog create sqlserver](sqlserver.md) — Create MS SQL Server catalog

- [yc managed-trino v0 catalog create tpcds](tpcds.md) — Create TPC-DS catalog

- [yc managed-trino v0 catalog create tpch](tpch.md) — Create TPC-H catalog

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