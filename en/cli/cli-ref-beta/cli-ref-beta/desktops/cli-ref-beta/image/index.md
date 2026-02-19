---
editable: false
noIndex: true
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