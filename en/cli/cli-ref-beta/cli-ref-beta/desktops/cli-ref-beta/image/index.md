---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/desktops/cli-ref-beta/image/index.md
---

# yc beta desktops image

A service for managing desktop images.

#### Command Usage

Syntax: 

`yc beta desktops image <command>`

#### Command Tree

- [yc beta desktops image copy](copy.md) — Copies the specified image to desktop image.
- [yc beta desktops image copy-from-desktop](copy-from-desktop.md) — Copies the specified desktop image from the specified desktop.
- [yc beta desktops image delete](delete.md) — Deletes the specified desktop image.
- [yc beta desktops image get](get.md) — Returns the specified desktop image.
- [yc beta desktops image list](list.md) — Lists desktop images in the specified folder.
- [yc beta desktops image update](update.md) — Updates desktop image properties.

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
