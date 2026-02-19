---
editable: false
noIndex: true
---

# yc beta compute disk

A set of methods for managing Disk resources.

#### Command Usage

Syntax:

`yc beta compute disk <command>`

#### Command Tree

- [yc beta compute disk create](create.md) — Creates a disk in the specified folder.

- [yc beta compute disk delete](delete.md) — Deletes the specified disk.

- [yc beta compute disk get](get.md) — Returns the specified Disk resource.

- [yc beta compute disk list](list.md) — Retrieves the list of Disk resources in the specified folder.

- [yc beta compute disk list-access-bindings](list-access-bindings.md) — Lists access bindings for the disk.

- [yc beta compute disk list-operations](list-operations.md) — Lists operations for the specified disk.

- [yc beta compute disk list-snapshot-schedules](list-snapshot-schedules.md) — Retrieves the list of snapshot schedules the specified disk is attached to.

- [yc beta compute disk move](move.md) — Moves the specified disk to another folder of the same cloud.

- [yc beta compute disk relocate](relocate.md) — Moves the specified disk to another availability zone

- [yc beta compute disk set-access-bindings](set-access-bindings.md) — Sets access bindings for the disk.

- [yc beta compute disk update](update.md) — Updates the specified disk.

- [yc beta compute disk update-access-bindings](update-access-bindings.md) — Updates access bindings for the disk.

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