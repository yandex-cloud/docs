[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник CLI (англ.)](../../../../../index.md) > [managed-trino](../../../index.md) > [v0](../../index.md) > [catalog](../index.md) > update > Overview

# yc managed-trino v0 catalog update

Update Trino catalog

#### Command Usage

Syntax:

`yc managed-trino catalog update <command>`

#### Command Tree

- [yc managed-trino v0 catalog update clickhouse](clickhouse.md) — Update ClickHouse catalog

- [yc managed-trino v0 catalog update delta-lake](delta-lake.md) — Update Delta Lake catalog

- [yc managed-trino v0 catalog update greenplum](greenplum.md) — Update Greenplum catalog

- [yc managed-trino v0 catalog update hive](hive.md) — Update Hive catalog

- [yc managed-trino v0 catalog update hudi](hudi.md) — Update Hudi catalog

- [yc managed-trino v0 catalog update iceberg](iceberg.md) — Update Iceberg catalog

- [yc managed-trino v0 catalog update mysql](mysql.md) — Update MySQL catalog

- [yc managed-trino v0 catalog update oracle](oracle.md) — Update Oracle catalog

- [yc managed-trino v0 catalog update postgresql](postgresql.md) — Update PostgreSQL catalog

- [yc managed-trino v0 catalog update sqlserver](sqlserver.md) — Update MS SQL Server catalog

- [yc managed-trino v0 catalog update tpcds](tpcds.md) — Update TPC-DS catalog

- [yc managed-trino v0 catalog update tpch](tpch.md) — Update TPC-H catalog

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