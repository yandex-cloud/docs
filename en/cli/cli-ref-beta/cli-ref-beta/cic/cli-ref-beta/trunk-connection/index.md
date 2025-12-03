---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/trunk-connection/index.md
---

# yc beta cic trunk-connection

A set of methods for managing TrunkConnection resources.

#### Command Usage

Syntax: 

`yc beta cic trunk-connection <command>`

#### Command Tree

- [yc beta cic trunk-connection create](create.md) — Creates a TrunkConnection resource in the specified folder using the data specified in the request.
- [yc beta cic trunk-connection delete](delete.md) — Deletes a TrunkConnection resource.
- [yc beta cic trunk-connection get](get.md) — Returns the specified TrunkConnection resource.
- [yc beta cic trunk-connection list](list.md) — Retrieves the list of TrunkConnection resources in the specified folder.
- [yc beta cic trunk-connection list-operations](list-operations.md) — Lists operations for the specified TrunkConnection.
- [yc beta cic trunk-connection move](move.md) — Moves the specified TrunkConnection to another folder.
- [yc beta cic trunk-connection update](update.md) — Updates a TrunkConnection resource using the data specified in the request.

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
