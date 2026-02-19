---
editable: false
noIndex: true
---

# yc beta compute snapshot

A set of methods for managing Snapshot resources.

#### Command Usage

Syntax:

`yc beta compute snapshot <command>`

#### Command Tree

- [yc beta compute snapshot create](create.md) — Creates a snapshot of the specified disk.

- [yc beta compute snapshot delete](delete.md) — Deletes the specified snapshot.

- [yc beta compute snapshot get](get.md) — Returns the specified Snapshot resource.

- [yc beta compute snapshot list](list.md) — Retrieves the list of Snapshot resources in the specified folder.

- [yc beta compute snapshot list-access-bindings](list-access-bindings.md) — Lists access bindings for the snapshot.

- [yc beta compute snapshot list-operations](list-operations.md) — Lists operations for the specified snapshot.

- [yc beta compute snapshot set-access-bindings](set-access-bindings.md) — Sets access bindings for the snapshot.

- [yc beta compute snapshot update](update.md) — Updates the specified snapshot.

- [yc beta compute snapshot update-access-bindings](update-access-bindings.md) — Updates access bindings for the snapshot.

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