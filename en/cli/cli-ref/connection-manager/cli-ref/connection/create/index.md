---
editable: false
sourcePath: en/_cli-ref/cli-ref/connection-manager/cli-ref/connection/create/index.md
---

# yc connection-manager connection create

Create connection

#### Command Usage

Syntax: 

`yc connection-manager connection create <command>`

#### Command Tree

- [yc connection-manager connection create clickhouse](clickhouse.md) — Create ClickHouse connection
- [yc connection-manager connection create greenplum](greenplum.md) — Create Greenplum connection
- [yc connection-manager connection create mongodb](mongodb.md) — Create MongoDB connection
- [yc connection-manager connection create mysql](mysql.md) — Create MySQL connection
- [yc connection-manager connection create opensearch](opensearch.md) — Create OpenSearch connection
- [yc connection-manager connection create postgresql](postgresql.md) — Create PostgreSQL connection
- [yc connection-manager connection create redis](redis.md) — Create Redis connection
- [yc connection-manager connection create trino](trino.md) — Create Trino connection
- [yc connection-manager connection create valkey](valkey.md) — Create Valkey connection

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
