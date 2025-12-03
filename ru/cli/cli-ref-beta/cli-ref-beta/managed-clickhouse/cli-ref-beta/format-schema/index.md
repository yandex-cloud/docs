---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-clickhouse/cli-ref-beta/format-schema/index.md
---

# yc beta managed-clickhouse format-schema

A set of methods for managing [format schemas](https://clickhouse.com/docs/en/interfaces/formats) for input and output data.

#### Command Usage

Syntax: 

`yc beta managed-clickhouse format-schema <command>`

#### Command Tree

- [yc beta managed-clickhouse format-schema create](create.md) — Adds a format schema to a cluster.
- [yc beta managed-clickhouse format-schema delete](delete.md) — Deletes a format schema from a cluster.
- [yc beta managed-clickhouse format-schema get](get.md) — Returns detailed information about a given format schema.
- [yc beta managed-clickhouse format-schema list](list.md) — Returns a list of format schemas in a cluster.
- [yc beta managed-clickhouse format-schema update](update.md) — Changes a format schema.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
