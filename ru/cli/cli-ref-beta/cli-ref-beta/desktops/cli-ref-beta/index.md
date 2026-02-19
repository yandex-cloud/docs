---
editable: false
noIndex: true
---

# yc beta desktops

[PREVIEW] Manage Desktop resources

#### Command Usage

Syntax:

`yc beta desktops <group>`

#### Command Tree

- [yc beta desktops desktop](desktop/index.md) — A set of methods for managing desktop resources.

  - [yc beta desktops desktop create](desktop/create.md) — Creates desktop in the specified folder.

  - [yc beta desktops desktop delete](desktop/delete.md) — Deletes the specified desktop.

  - [yc beta desktops desktop get](desktop/get.md) — Returns the specified desktop resource.

  - [yc beta desktops desktop get-rdp-file](desktop/get-rdp-file.md) — Returns a RDP file for the specified desktop.

  - [yc beta desktops desktop list](desktop/list.md) — Retrieves the list of desktop resources.

  - [yc beta desktops desktop list-operations](desktop/list-operations.md) — Returns list of the operations for the specified desktop.

  - [yc beta desktops desktop reset-password](desktop/reset-password.md) — Reset password

  - [yc beta desktops desktop restart](desktop/restart.md) — Restart the specified desktop.

  - [yc beta desktops desktop start](desktop/start.md) — Start the specified desktop.

  - [yc beta desktops desktop stop](desktop/stop.md) — Stop the specified desktop.

  - [yc beta desktops desktop update](desktop/update.md) — Sync desktop with group configuration

  - [yc beta desktops desktop update-properties](desktop/update-properties.md) — Updates desktop properties.

- [yc beta desktops group](group/index.md) — A set of methods for managing desktop group resources.

  - [yc beta desktops group create](group/create.md) — Creates desktop group in the specified folder.

  - [yc beta desktops group delete](group/delete.md) — Deletes the specified desktop group.

  - [yc beta desktops group get](group/get.md) — Returns the specified desktop group resource.

  - [yc beta desktops group list](group/list.md) — Retrieves the list of desktop group resources.

  - [yc beta desktops group list-access-bindings](group/list-access-bindings.md) — Returns a list of the access bindings for the specified desktop group.

  - [yc beta desktops group list-desktops](group/list-desktops.md) — Retrieves the list of desktops resources.

  - [yc beta desktops group list-operations](group/list-operations.md) — Returns list of the operations for the specified desktop group.

  - [yc beta desktops group set-access-bindings](group/set-access-bindings.md) — Sets access bindings for the specified desktop group.

  - [yc beta desktops group update](group/update.md) — Updates desktop group properties

  - [yc beta desktops group update-access-bindings](group/update-access-bindings.md) — Updates access bindings of the specified desktop group.

- [yc beta desktops image](image/index.md) — A service for managing desktop images.

  - [yc beta desktops image copy](image/copy.md) — Copies the specified image to desktop image.

  - [yc beta desktops image copy-from-desktop](image/copy-from-desktop.md) — Copies the specified desktop image from the specified desktop.

  - [yc beta desktops image delete](image/delete.md) — Deletes the specified desktop image.

  - [yc beta desktops image get](image/get.md) — Returns the specified desktop image.

  - [yc beta desktops image list](image/list.md) — Lists desktop images in the specified folder.

  - [yc beta desktops image update](image/update.md) — Updates desktop image properties.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#