---
editable: false
---

# yc managed-trino catalog

Manage Trino catalogs

#### Command Usage

Syntax: 

`yc managed-trino catalog <group|command>`

Aliases: 

- `catalogs`

#### Command Tree

- [yc managed-trino catalog delete](delete.md) — Delete the specified Trino catalog
- [yc managed-trino catalog get](get.md) — Show information about the specified Trino catalog
- [yc managed-trino catalog list](list.md) — List Trino catalogs
- [yc managed-trino catalog create](create/index.md) — Create Trino catalog
	- [yc managed-trino catalog create clickhouse](create/clickhouse.md) — Create ClickHouse catalog
	- [yc managed-trino catalog create delta-lake](create/delta-lake.md) — Create Delta Lake catalog
	- [yc managed-trino catalog create hive](create/hive.md) — Create Hive catalog
	- [yc managed-trino catalog create iceberg](create/iceberg.md) — Create Iceberg catalog
	- [yc managed-trino catalog create oracle](create/oracle.md) — Create Oracle catalog
	- [yc managed-trino catalog create postgresql](create/postgresql.md) — Create PostgreSQL catalog
	- [yc managed-trino catalog create sqlserver](create/sqlserver.md) — Create MS SQL Server catalog
	- [yc managed-trino catalog create tpcds](create/tpcds.md) — Create TPC-DS catalog
	- [yc managed-trino catalog create tpch](create/tpch.md) — Create TPC-H catalog
- [yc managed-trino catalog update](update/index.md) — Update Trino catalog
	- [yc managed-trino catalog update clickhouse](update/clickhouse.md) — Update ClickHouse catalog
	- [yc managed-trino catalog update delta-lake](update/delta-lake.md) — Update Delta Lake catalog
	- [yc managed-trino catalog update hive](update/hive.md) — Update Hive catalog
	- [yc managed-trino catalog update iceberg](update/iceberg.md) — Update Iceberg catalog
	- [yc managed-trino catalog update oracle](update/oracle.md) — Update Oracle catalog
	- [yc managed-trino catalog update postgresql](update/postgresql.md) — Update PostgreSQL catalog
	- [yc managed-trino catalog update sqlserver](update/sqlserver.md) — Update MS SQL Server catalog
	- [yc managed-trino catalog update tpcds](update/tpcds.md) — Update TPC-DS catalog
	- [yc managed-trino catalog update tpch](update/tpch.md) — Update TPC-H catalog

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
