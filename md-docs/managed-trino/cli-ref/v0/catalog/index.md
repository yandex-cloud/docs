# yc managed-trino v0 catalog

Manage Trino catalogs

#### Command Usage

Syntax:

`yc managed-trino catalog <group|command>`

Aliases:

- `catalogs`

#### Command Tree

- [yc managed-trino v0 catalog delete](delete.md) — Delete the specified Trino catalog

- [yc managed-trino v0 catalog get](get.md) — Show information about the specified Trino catalog

- [yc managed-trino v0 catalog list](list.md) — List Trino catalogs

- [yc managed-trino v0 catalog create](create/index.md) — Create Trino catalog

  - [yc managed-trino v0 catalog create clickhouse](create/clickhouse.md) — Create ClickHouse catalog

  - [yc managed-trino v0 catalog create delta-lake](create/delta-lake.md) — Create Delta Lake catalog

  - [yc managed-trino v0 catalog create greenplum](create/greenplum.md) — Create Greenplum catalog

  - [yc managed-trino v0 catalog create hive](create/hive.md) — Create Hive catalog

  - [yc managed-trino v0 catalog create hudi](create/hudi.md) — Create Hudi catalog

  - [yc managed-trino v0 catalog create iceberg](create/iceberg.md) — Create Iceberg catalog

  - [yc managed-trino v0 catalog create mysql](create/mysql.md) — Create MySQL catalog

  - [yc managed-trino v0 catalog create oracle](create/oracle.md) — Create Oracle catalog

  - [yc managed-trino v0 catalog create postgresql](create/postgresql.md) — Create PostgreSQL catalog

  - [yc managed-trino v0 catalog create sqlserver](create/sqlserver.md) — Create MS SQL Server catalog

  - [yc managed-trino v0 catalog create tpcds](create/tpcds.md) — Create TPC-DS catalog

  - [yc managed-trino v0 catalog create tpch](create/tpch.md) — Create TPC-H catalog

- [yc managed-trino v0 catalog update](update/index.md) — Update Trino catalog

  - [yc managed-trino v0 catalog update clickhouse](update/clickhouse.md) — Update ClickHouse catalog

  - [yc managed-trino v0 catalog update delta-lake](update/delta-lake.md) — Update Delta Lake catalog

  - [yc managed-trino v0 catalog update greenplum](update/greenplum.md) — Update Greenplum catalog

  - [yc managed-trino v0 catalog update hive](update/hive.md) — Update Hive catalog

  - [yc managed-trino v0 catalog update hudi](update/hudi.md) — Update Hudi catalog

  - [yc managed-trino v0 catalog update iceberg](update/iceberg.md) — Update Iceberg catalog

  - [yc managed-trino v0 catalog update mysql](update/mysql.md) — Update MySQL catalog

  - [yc managed-trino v0 catalog update oracle](update/oracle.md) — Update Oracle catalog

  - [yc managed-trino v0 catalog update postgresql](update/postgresql.md) — Update PostgreSQL catalog

  - [yc managed-trino v0 catalog update sqlserver](update/sqlserver.md) — Update MS SQL Server catalog

  - [yc managed-trino v0 catalog update tpcds](update/tpcds.md) — Update TPC-DS catalog

  - [yc managed-trino v0 catalog update tpch](update/tpch.md) — Update TPC-H catalog

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