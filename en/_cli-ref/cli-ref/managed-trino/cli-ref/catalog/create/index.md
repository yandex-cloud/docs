---
editable: false
---

# yc managed-trino catalog create

Create Trino catalog

#### Command Usage

Syntax: 

`yc managed-trino catalog create <command>`

#### Command Tree

- [yc managed-trino catalog create clickhouse](clickhouse.md) — Create ClickHouse catalog
- [yc managed-trino catalog create delta-lake](delta-lake.md) — Create Delta Lake catalog
- [yc managed-trino catalog create hive](hive.md) — Create Hive catalog
- [yc managed-trino catalog create iceberg](iceberg.md) — Create Iceberg catalog
- [yc managed-trino catalog create oracle](oracle.md) — Create Oracle catalog
- [yc managed-trino catalog create postgresql](postgresql.md) — Create PostgreSQL catalog
- [yc managed-trino catalog create sqlserver](sqlserver.md) — Create MS SQL Server catalog
- [yc managed-trino catalog create tpcds](tpcds.md) — Create TPC-DS catalog
- [yc managed-trino catalog create tpch](tpch.md) — Create TPC-H catalog

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
