---
editable: false
sourcePath: en/_cli-ref/cli-ref/connection-manager/cli-ref/connection/update/index.md
---

# yc connection-manager connection update

Update connection

#### Command Usage

Syntax: 

`yc connection-manager connection update <command>`

#### Command Tree

- [yc connection-manager connection update clickhouse](clickhouse.md) — Update ClickHouse connection
- [yc connection-manager connection update greenplum](greenplum.md) — Update Greenplum connection
- [yc connection-manager connection update mongodb](mongodb.md) — Update MongoDB connection
- [yc connection-manager connection update mysql](mysql.md) — Update MySQL connection
- [yc connection-manager connection update opensearch](opensearch.md) — Update OpenSearch connection
- [yc connection-manager connection update postgresql](postgresql.md) — Update PostgreSQL connection
- [yc connection-manager connection update redis](redis.md) — Update Redis connection
- [yc connection-manager connection update trino](trino.md) — Update Trino connection
- [yc connection-manager connection update valkey](valkey.md) — Update Valkey connection

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
