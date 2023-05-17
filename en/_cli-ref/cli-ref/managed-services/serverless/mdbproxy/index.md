---
editable: false
---

# yc serverless mdbproxy

Manage proxies

#### Command Usage

Syntax: 

`yc serverless mdbproxy <group|command>`

#### Command Tree

- [yc serverless mdbproxy get](get.md) — Show information about the specified proxy
- [yc serverless mdbproxy list](list.md) — List proxies
- [yc serverless mdbproxy add-labels](add-labels.md) — Add labels to specified proxy
- [yc serverless mdbproxy remove-labels](remove-labels.md) — Remove labels from specified proxy
- [yc serverless mdbproxy delete](delete.md) — Delete the specified proxy
- [yc serverless mdbproxy list-operations](list-operations.md) — Show history of the tag for the specified proxy
- [yc serverless mdbproxy update](update/index.md) — Update the specified proxy
	- [yc serverless mdbproxy update postgresql](update/postgresql.md) — Update the specified proxy
	- [yc serverless mdbproxy update clickhouse](update/clickhouse.md) — Update the specified proxy
- [yc serverless mdbproxy create](create/index.md) — Create proxies
	- [yc serverless mdbproxy create postgresql](create/postgresql.md) — Create postgres proxy
	- [yc serverless mdbproxy create clickhouse](create/clickhouse.md) — Create clickhouse proxy

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
