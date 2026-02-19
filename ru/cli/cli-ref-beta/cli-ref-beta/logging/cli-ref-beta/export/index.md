---
editable: false
noIndex: true
---

# yc beta logging export

A set of methods for managing log exports.

#### Command Usage

Syntax:

`yc beta logging export <command>`

#### Command Tree

- [yc beta logging export create](create.md) — Creates a export in the specified folder.

- [yc beta logging export delete](delete.md) — Deletes the specified export.

- [yc beta logging export get](get.md) — Returns the specified export.

- [yc beta logging export list](list.md) — Retrieves the list of exports in the specified folder.

- [yc beta logging export list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified export.

- [yc beta logging export list-operations](list-operations.md) — Lists operations for the specified export.

- [yc beta logging export run](run.md) — Run new logs export from log group to sink

- [yc beta logging export set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified export.

- [yc beta logging export update](update.md) — Updates the specified export.

- [yc beta logging export update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified export.

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