---
editable: false
---

# yc datatransfer endpoint

Manage endpoints

#### Command Usage

Syntax: 

`yc datatransfer endpoint <group|command>`

#### Command Tree

- [yc datatransfer endpoint get](get.md) — Get endpoint
- [yc datatransfer endpoint delete](delete.md) — Delete endpoint
- [yc datatransfer endpoint list](list.md) — List endpoints in folder
- [yc datatransfer endpoint create](create/index.md) — Create endpoint
	- [yc datatransfer endpoint create postgres-source](create/postgres-source.md) — Create PostgreSQL source
	- [yc datatransfer endpoint create postgres-target](create/postgres-target.md) — Create PostgreSQL target
	- [yc datatransfer endpoint create mysql-source](create/mysql-source.md) — Create MySQL source
	- [yc datatransfer endpoint create mysql-target](create/mysql-target.md) — Create MySQL target
	- [yc datatransfer endpoint create mongo-source](create/mongo-source.md) — Create MongoDB source
	- [yc datatransfer endpoint create mongo-target](create/mongo-target.md) — Create MongoDB target
	- [yc datatransfer endpoint create clickhouse-source](create/clickhouse-source.md) — Create Clickhouse source
	- [yc datatransfer endpoint create clickhouse-target](create/clickhouse-target.md) — Create Clickhouse target
- [yc datatransfer endpoint update](update/index.md) — Update endpoint
	- [yc datatransfer endpoint update postgres-source](update/postgres-source.md) — Update PostgreSQL source
	- [yc datatransfer endpoint update postgres-target](update/postgres-target.md) — Update PostgreSQL target
	- [yc datatransfer endpoint update mysql-source](update/mysql-source.md) — Update MySQL source
	- [yc datatransfer endpoint update mysql-target](update/mysql-target.md) — Update MySQL target
	- [yc datatransfer endpoint update mongo-source](update/mongo-source.md) — Update MongoDB source
	- [yc datatransfer endpoint update mongo-target](update/mongo-target.md) — Update MongoDB target
	- [yc datatransfer endpoint update clickhouse-source](update/clickhouse-source.md) — Update Clickhouse source
	- [yc datatransfer endpoint update clickhouse-target](update/clickhouse-target.md) — Update Clickhouse target

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
