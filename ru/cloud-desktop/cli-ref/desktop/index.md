---
editable: false
sourcePath: en/_cli-ref/cli-ref/desktops/cli-ref/desktop/index.md
---

# yc desktops desktop

[PREVIEW] Manage desktop instances

#### Command Usage

Syntax: 

`yc desktops desktop <command>`

#### Command Tree

- [yc desktops desktop create](create.md) — Create a desktop
- [yc desktops desktop delete](delete.md) — Delete the specified desktop
- [yc desktops desktop get](get.md) — Get information about a desktop
- [yc desktops desktop get-rdp-file](get-rdp-file.md) — Download desktop RDP file
- [yc desktops desktop list](list.md) — List desktops
- [yc desktops desktop list-operations](list-operations.md) — List operations for the specified desktop
- [yc desktops desktop reset-password](reset-password.md) — Reset desktop Password
- [yc desktops desktop restart](restart.md) — Restart the specified desktop
- [yc desktops desktop start](start.md) — Start the specified desktop
- [yc desktops desktop stop](stop.md) — Stop the specified desktop
- [yc desktops desktop update](update.md) — Update the specified desktop
- [yc desktops desktop update-properties](update-properties.md) — Update a desktop

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
