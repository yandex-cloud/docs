---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-clickhouse/cli-ref/format-schema/index.md
---

# yc managed-clickhouse format-schema

Manage ClickHouse format schemas.

#### Command Usage

Syntax: 

`yc managed-clickhouse format-schema <command>`

Aliases: 

- `format-schemas`

#### Command Tree

- [yc managed-clickhouse format-schema create](create.md) — Create format schema in a ClickHouse cluster.
- [yc managed-clickhouse format-schema delete](delete.md) — Delete ClickHouse format schema.
- [yc managed-clickhouse format-schema get](get.md) — Get information about a ClickHouse format schema.
- [yc managed-clickhouse format-schema list](list.md) — List format schemas in a ClickHouse cluster.
- [yc managed-clickhouse format-schema update](update.md) — Modify configuration or attributes of a ClickHouse format schema.

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
