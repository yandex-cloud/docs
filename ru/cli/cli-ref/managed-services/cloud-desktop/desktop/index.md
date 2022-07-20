---
sourcePath: en/_cli-ref/cli-ref/managed-services/cloud-desktop/desktop/index.md
---
# yc cloud-desktop desktop

[PREVIEW] Manage VDI resources

#### Command Usage

Syntax: 

`yc cloud-desktop desktop <command>`

#### Command Tree

- [yc cloud-desktop desktop get](get.md) — Get information about a desktop.
- [yc cloud-desktop desktop list](list.md) — List desktops.
- [yc cloud-desktop desktop get-rdp-file](get-rdp-file.md) — Download desktop RDP file.
- [yc cloud-desktop desktop list-operations](list-operations.md) — List operations for the specified desktop
- [yc cloud-desktop desktop create](create.md) — Create an desktop
- [yc cloud-desktop desktop delete](delete.md) — Delete the specified desktop
- [yc cloud-desktop desktop reset-password](reset-password.md) — Reset desktop Password.

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
