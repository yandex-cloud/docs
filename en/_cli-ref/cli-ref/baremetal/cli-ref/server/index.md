---
editable: false
---

# yc baremetal server

Manage servers

#### Command Usage

Syntax: 

`yc baremetal server <command>`

#### Command Tree

- [yc baremetal server add-labels](add-labels.md) — Add labels to specified server
- [yc baremetal server create](create.md) — Create an server
- [yc baremetal server get](get.md) — Show information about the specified server
- [yc baremetal server list](list.md) — List servers
- [yc baremetal server list-operations](list-operations.md) — List operations for the specified server
- [yc baremetal server power-off](power-off.md) — Power Off the specified server
- [yc baremetal server power-on](power-on.md) — Power On the specified server
- [yc baremetal server reboot](reboot.md) — Power Off the specified server
- [yc baremetal server reinstall](reinstall.md) — Reinstall the specified server
- [yc baremetal server remove-labels](remove-labels.md) — Remove labels from specified server
- [yc baremetal server update](update.md) — Update the specified server

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
