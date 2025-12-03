---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/metadata-hub/cli-ref-beta/connection-manager/connection/index.md
---

# yc beta metadata-hub connection-manager connection

A set of methods for managing Connection resources.

#### Command Usage

Syntax: 

`yc beta metadata-hub connection-manager connection <command>`

#### Command Tree

- [yc beta metadata-hub connection-manager connection create](create.md) — Creates connection.
- [yc beta metadata-hub connection-manager connection delete](delete.md) — Delete specified connection.
- [yc beta metadata-hub connection-manager connection get](get.md) — Returns connection.
- [yc beta metadata-hub connection-manager connection list](list.md) — List connections in specified folder.
- [yc beta metadata-hub connection-manager connection list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified connection.
- [yc beta metadata-hub connection-manager connection resolve-cluster](resolve-cluster.md) — Returns the connection with the resolved cluster; that is,
- [yc beta metadata-hub connection-manager connection update](update.md) — Updates specified connection.

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
