---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/server/index.md
---

# yc beta baremetal server

A set of methods for managing Server resources.

#### Command Usage

Syntax: 

`yc beta baremetal server <command>`

#### Command Tree

- [yc beta baremetal server batch-create](batch-create.md) — Creates multiple servers in the specified folder.
- [yc beta baremetal server create](create.md) — Creates a server in the specified folder.
- [yc beta baremetal server get](get.md) — Returns the specific Server resource.
- [yc beta baremetal server list](list.md) — Retrieves the list of Server resources in the specified folder.
- [yc beta baremetal server list-operations](list-operations.md) — Lists operations for the specified server.
- [yc beta baremetal server power-off](power-off.md) — Powers off the specified server.
- [yc beta baremetal server power-on](power-on.md) — Powers on the specified server.
- [yc beta baremetal server reboot](reboot.md) — Reboots the specified server.
- [yc beta baremetal server reinstall](reinstall.md) — Reinstalls the specified server.
- [yc beta baremetal server start-prolongation](start-prolongation.md) — Starts prolongation of the specified server.
- [yc beta baremetal server stop-prolongation](stop-prolongation.md) — Stops prolongation of the specified server.
- [yc beta baremetal server update](update.md) — Updates the specified server.

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
