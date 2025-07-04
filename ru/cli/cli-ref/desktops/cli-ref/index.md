---
editable: false
sourcePath: en/_cli-ref/cli-ref/desktops/cli-ref/index.md
---

# yc desktops

[PREVIEW] Manage Desktop resources

#### Command Usage

Syntax: 

`yc desktops <group>`

#### Command Tree

- [yc desktops desktop](desktop/index.md) — [PREVIEW] Manage desktop instances
	- [yc desktops desktop create](desktop/create.md) — Create a desktop
	- [yc desktops desktop delete](desktop/delete.md) — Delete the specified desktop
	- [yc desktops desktop get](desktop/get.md) — Get information about a desktop
	- [yc desktops desktop get-rdp-file](desktop/get-rdp-file.md) — Download desktop RDP file
	- [yc desktops desktop list](desktop/list.md) — List desktops
	- [yc desktops desktop list-operations](desktop/list-operations.md) — List operations for the specified desktop
	- [yc desktops desktop reset-password](desktop/reset-password.md) — Reset desktop Password
	- [yc desktops desktop restart](desktop/restart.md) — Restart the specified desktop
	- [yc desktops desktop start](desktop/start.md) — Start the specified desktop
	- [yc desktops desktop stop](desktop/stop.md) — Stop the specified desktop
	- [yc desktops desktop update](desktop/update.md) — Update the specified desktop
	- [yc desktops desktop update-properties](desktop/update-properties.md) — Update a desktop
- [yc desktops group](group/index.md) — [PREVIEW] Manage desktop groups
	- [yc desktops group add-access-bindings](group/add-access-bindings.md) — Add access binding for the specified desktop group
	- [yc desktops group create](group/create.md) — Create a desktop group
	- [yc desktops group delete](group/delete.md) — Delete the specified desktop group
	- [yc desktops group get](group/get.md) — Get information about a desktop group
	- [yc desktops group list](group/list.md) — List desktops
	- [yc desktops group list-access-bindings](group/list-access-bindings.md) — List access bindings for the specified desktop group
	- [yc desktops group list-desktops](group/list-desktops.md) — List desktops of the specified desktop group
	- [yc desktops group list-operations](group/list-operations.md) — List operations for the specified desktop group
	- [yc desktops group remove-access-bindings](group/remove-access-bindings.md) — Remove access binding for the specified desktop group
	- [yc desktops group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified desktop group and delete all existing access bindings if there were any
	- [yc desktops group update](group/update.md) — Update desktop group
- [yc desktops image](image/index.md) — [PREVIEW] Manage desktop images
	- [yc desktops image copy](image/copy.md) — Create desktop image as copy of the specified desktop or compute image
	- [yc desktops image delete](image/delete.md) — Delete the specified desktop image
	- [yc desktops image get](image/get.md) — Get information about a desktop image
	- [yc desktops image list](image/list.md) — List desktop images
	- [yc desktops image update](image/update.md) — Update the specified desktop image

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
