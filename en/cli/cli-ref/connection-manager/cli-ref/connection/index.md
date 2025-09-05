---
editable: false
sourcePath: en/_cli-ref/cli-ref/connection-manager/cli-ref/connection/index.md
---

# yc connection-manager connection

Manage connections

#### Command Usage

Syntax: 

`yc connection-manager connection <group|command>`

#### Command Tree

- [yc connection-manager connection delete](delete.md) — Delete connection
- [yc connection-manager connection get](get.md) — Get connection
- [yc connection-manager connection list](list.md) — List connections
- [yc connection-manager connection list-operations](list-operations.md) — List operations for the specified connection
- [yc connection-manager connection resolve-cluster](resolve-cluster.md) — Resolve cluster
- [yc connection-manager connection create](create/index.md) — Create connection
	- [yc connection-manager connection create clickhouse](create/clickhouse.md) — Create ClickHouse connection
	- [yc connection-manager connection create greenplum](create/greenplum.md) — Create Greenplum connection
	- [yc connection-manager connection create mongodb](create/mongodb.md) — Create MongoDB connection
	- [yc connection-manager connection create mysql](create/mysql.md) — Create MySQL connection
	- [yc connection-manager connection create opensearch](create/opensearch.md) — Create OpenSearch connection
	- [yc connection-manager connection create postgresql](create/postgresql.md) — Create PostgreSQL connection
	- [yc connection-manager connection create redis](create/redis.md) — Create Redis connection
	- [yc connection-manager connection create trino](create/trino.md) — Create Trino connection
	- [yc connection-manager connection create valkey](create/valkey.md) — Create Valkey connection
- [yc connection-manager connection update](update/index.md) — Update connection
	- [yc connection-manager connection update clickhouse](update/clickhouse.md) — Update ClickHouse connection
	- [yc connection-manager connection update greenplum](update/greenplum.md) — Update Greenplum connection
	- [yc connection-manager connection update mongodb](update/mongodb.md) — Update MongoDB connection
	- [yc connection-manager connection update mysql](update/mysql.md) — Update MySQL connection
	- [yc connection-manager connection update opensearch](update/opensearch.md) — Update OpenSearch connection
	- [yc connection-manager connection update postgresql](update/postgresql.md) — Update PostgreSQL connection
	- [yc connection-manager connection update redis](update/redis.md) — Update Redis connection
	- [yc connection-manager connection update trino](update/trino.md) — Update Trino connection
	- [yc connection-manager connection update valkey](update/valkey.md) — Update Valkey connection

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
