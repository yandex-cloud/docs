---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/route-table/index.md
---

# yc beta vpc route-table

A set of methods for managing RouteTable resources.

#### Command Usage

Syntax: 

`yc beta vpc route-table <command>`

#### Command Tree

- [yc beta vpc route-table create](create.md) — Creates a route table in the specified folder and network.
- [yc beta vpc route-table delete](delete.md) — Deletes the specified route table.
- [yc beta vpc route-table get](get.md) — Returns the specified RouteTable resource.
- [yc beta vpc route-table list](list.md) — Retrieves the list of RouteTable resources in the specified folder.
- [yc beta vpc route-table list-operations](list-operations.md) — List operations for the specified route table.
- [yc beta vpc route-table move](move.md) — Move route table to another folder.
- [yc beta vpc route-table update](update.md) — Updates the specified route table.

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
