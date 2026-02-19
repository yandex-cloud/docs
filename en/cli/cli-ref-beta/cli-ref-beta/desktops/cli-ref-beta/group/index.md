---
editable: false
noIndex: true
---

# yc beta desktops group

A set of methods for managing desktop group resources.

#### Command Usage

Syntax:

`yc beta desktops group <command>`

#### Command Tree

- [yc beta desktops group create](create.md) — Creates desktop group in the specified folder.

- [yc beta desktops group delete](delete.md) — Deletes the specified desktop group.

- [yc beta desktops group get](get.md) — Returns the specified desktop group resource.

- [yc beta desktops group list](list.md) — Retrieves the list of desktop group resources.

- [yc beta desktops group list-access-bindings](list-access-bindings.md) — Returns a list of the access bindings for the specified desktop group.

- [yc beta desktops group list-desktops](list-desktops.md) — Retrieves the list of desktops resources.

- [yc beta desktops group list-operations](list-operations.md) — Returns list of the operations for the specified desktop group.

- [yc beta desktops group set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified desktop group.

- [yc beta desktops group update](update.md) — Updates desktop group properties

- [yc beta desktops group update-access-bindings](update-access-bindings.md) — Updates access bindings of the specified desktop group.

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