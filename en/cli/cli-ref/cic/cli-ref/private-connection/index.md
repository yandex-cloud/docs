---
editable: false
sourcePath: en/_cli-ref/cli-ref/cic/cli-ref/private-connection/index.md
---

# yc cic private-connection

[PREVIEW] Manage privateConnections.

#### Command Usage

Syntax: 

`yc cic private-connection <command>`

Aliases: 

- `private-connections`
- `prc`

#### Command Tree

- [yc cic private-connection add-labels](add-labels.md) — Assign labels to a privateConnection.
- [yc cic private-connection create](create.md) — Create a privateConnection.
- [yc cic private-connection delete](delete.md) — Delete a privateConnection.
- [yc cic private-connection get](get.md) — Get information about a privateConnection.
- [yc cic private-connection list](list.md) — List privateConnections in a folder.
- [yc cic private-connection list-operations](list-operations.md) — List operations for a privateConnection.
- [yc cic private-connection remove-labels](remove-labels.md) — Remove labels from a privateConnection.
- [yc cic private-connection remove-static-routes](remove-static-routes.md) — Remove static routes from a privateConnection.
- [yc cic private-connection update](update.md) — Modify configuration or attributes of a privateConnection.
- [yc cic private-connection upsert-static-routes](upsert-static-routes.md) — Upsert static routes to a privateConnection.

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
