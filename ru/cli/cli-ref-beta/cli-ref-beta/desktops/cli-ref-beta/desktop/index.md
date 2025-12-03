---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/desktops/cli-ref-beta/desktop/index.md
---

# yc beta desktops desktop

A set of methods for managing desktop resources.

#### Command Usage

Syntax: 

`yc beta desktops desktop <command>`

#### Command Tree

- [yc beta desktops desktop create](create.md) — Creates desktop in the specified folder.
- [yc beta desktops desktop delete](delete.md) — Deletes the specified desktop.
- [yc beta desktops desktop get](get.md) — Returns the specified desktop resource.
- [yc beta desktops desktop get-rdp-file](get-rdp-file.md) — Returns a RDP file for the specified desktop.
- [yc beta desktops desktop list](list.md) — Retrieves the list of desktop resources.
- [yc beta desktops desktop list-operations](list-operations.md) — Returns list of the operations for the specified desktop.
- [yc beta desktops desktop reset-password](reset-password.md) — Reset password
- [yc beta desktops desktop restart](restart.md) — Restart the specified desktop.
- [yc beta desktops desktop start](start.md) — Start the specified desktop.
- [yc beta desktops desktop stop](stop.md) — Stop the specified desktop.
- [yc beta desktops desktop update](update.md) — Sync desktop with group configuration
- [yc beta desktops desktop update-properties](update-properties.md) — Updates desktop properties.

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
