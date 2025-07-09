---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-trino/cli-ref/catalog/update/index.md
---

# yc managed-trino catalog update

Update Trino catalog

#### Command Usage

Syntax: 

`yc managed-trino catalog update <command>`

#### Command Tree

- [yc managed-trino catalog update clickhouse](clickhouse.md) — Update ClickHouse catalog
- [yc managed-trino catalog update delta-lake](delta-lake.md) — Update Delta Lake catalog
- [yc managed-trino catalog update hive](hive.md) — Update Hive catalog
- [yc managed-trino catalog update iceberg](iceberg.md) — Update Iceberg catalog
- [yc managed-trino catalog update oracle](oracle.md) — Update Oracle catalog
- [yc managed-trino catalog update postgresql](postgresql.md) — Update PostgreSQL catalog
- [yc managed-trino catalog update sqlserver](sqlserver.md) — Update MS SQL Server catalog
- [yc managed-trino catalog update tpcds](tpcds.md) — Update TPC-DS catalog
- [yc managed-trino catalog update tpch](tpch.md) — Update TPC-H catalog

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
