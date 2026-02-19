---
editable: false
noIndex: true
---

# yc beta compute snapshot-schedule

A set of methods for managing snapshot schedules.

#### Command Usage

Syntax:

`yc beta compute snapshot-schedule <command>`

#### Command Tree

- [yc beta compute snapshot-schedule create](create.md) — Creates a snapshot schedule in the specified folder.

- [yc beta compute snapshot-schedule delete](delete.md) — Deletes the specified snapshot schedule.

- [yc beta compute snapshot-schedule disable](disable.md) — Disables the specified snapshot schedule.

- [yc beta compute snapshot-schedule enable](enable.md) — Enables the specified snapshot schedule.

- [yc beta compute snapshot-schedule get](get.md) — Returns the specified snapshot schedule.

- [yc beta compute snapshot-schedule list](list.md) — Retrieves the list of snapshot schedules in the specified folder.

- [yc beta compute snapshot-schedule list-access-bindings](list-access-bindings.md) — Lists access bindings for the snapshot schedule.

- [yc beta compute snapshot-schedule list-disks](list-disks.md) — Retrieves the list of disks attached to the specified snapshot schedule.

- [yc beta compute snapshot-schedule list-operations](list-operations.md) — Lists operations for the specified snapshot schedule.

- [yc beta compute snapshot-schedule list-snapshots](list-snapshots.md) — Retrieves the list of snapshots created by the specified snapshot schedule.

- [yc beta compute snapshot-schedule set-access-bindings](set-access-bindings.md) — Sets access bindings for the snapshot schedule.

- [yc beta compute snapshot-schedule update](update.md) — Updates the specified snapshot schedule.

- [yc beta compute snapshot-schedule update-access-bindings](update-access-bindings.md) — Updates access bindings for the snapshot schedule.

- [yc beta compute snapshot-schedule update-disks](update-disks.md) — Updates the list of disks attached to the specified schedule.

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