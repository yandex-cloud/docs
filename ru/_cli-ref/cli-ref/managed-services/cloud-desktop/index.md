# yc cloud-desktop

Manage cloud desktop resources.

#### Command Usage

Syntax: 

`yc cloud-desktop <group>`

#### Command Tree

- [yc cloud-desktop desktop](desktop/index.md) — [PREVIEW] Manage VDI resources
	- [yc cloud-desktop desktop get](desktop/get.md) — Get information about a desktop.
	- [yc cloud-desktop desktop list](desktop/list.md) — List desktops.
	- [yc cloud-desktop desktop get-rdp-file](desktop/get-rdp-file.md) — Download desktop RDP file.
	- [yc cloud-desktop desktop list-operations](desktop/list-operations.md) — List operations for the specified desktop
	- [yc cloud-desktop desktop create](desktop/create.md) — Create an desktop
	- [yc cloud-desktop desktop delete](desktop/delete.md) — Delete the specified desktop
	- [yc cloud-desktop desktop reset-password](desktop/reset-password.md) — Reset desktop Password.
- [yc cloud-desktop group](group/index.md) — [PREVIEW] Manage cloud desktop resources
	- [yc cloud-desktop group get](group/get.md) — Get information about a desktop group.
	- [yc cloud-desktop group list](group/list.md) — List desktops.
	- [yc cloud-desktop group list-desktops](group/list-desktops.md) — List desktops of the specified desktop group.
	- [yc cloud-desktop group list-operations](group/list-operations.md) — List operations for the specified desktop group
	- [yc cloud-desktop group create](group/create.md) — Create a desktop group
	- [yc cloud-desktop group delete](group/delete.md) — Delete the specified desktop group
	- [yc cloud-desktop group list-access-bindings](group/list-access-bindings.md) — List access bindings for the specified desktop group
	- [yc cloud-desktop group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified desktop group and delete all existing access bindings if there were any
	- [yc cloud-desktop group add-access-bindings](group/add-access-bindings.md) — Add access binding for the specified desktop group
	- [yc cloud-desktop group remove-access-bindings](group/remove-access-bindings.md) — Remove access binding for the specified desktop group

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
