---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/private-connection/index.md
---

# yc beta cic private-connection

A set of methods for managing PrivateConnection resources.

#### Command Usage

Syntax: 

`yc beta cic private-connection <command>`

#### Command Tree

- [yc beta cic private-connection create](create.md) — Creates a PrivateConnection resource in the specified folder using the data specified in the request.
- [yc beta cic private-connection delete](delete.md) — Deletes a PrivateConnection resource.
- [yc beta cic private-connection get](get.md) — Returns the specified PrivateConnection resource.
- [yc beta cic private-connection list](list.md) — Retrieves the list of PrivateConnection resources in the specified folder.
- [yc beta cic private-connection list-operations](list-operations.md) — Lists operations for the specified PrivateConnection.
- [yc beta cic private-connection move](move.md) — Moves the specified PrivateConnection to another folder.
- [yc beta cic private-connection remove-static-route](remove-static-route.md) — Removes specified static routes to a PrivateConnection resource.
- [yc beta cic private-connection update](update.md) — Updates a PrivateConnection resource using the data specified in the request.
- [yc beta cic private-connection upsert-static-route](upsert-static-route.md) — Upserts specified static routes to a PrivateConnection resource.

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
