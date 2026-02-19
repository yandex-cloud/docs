---
editable: false
noIndex: true
---

# yc beta compute host-group

A set of methods for managing groups of dedicated hosts.

#### Command Usage

Syntax:

`yc beta compute host-group <command>`

#### Command Tree

- [yc beta compute host-group create](create.md) — Creates a host group in the specified folder.

- [yc beta compute host-group delete](delete.md) — Deletes the specified host group.

- [yc beta compute host-group get](get.md) — Returns the specified host group.

- [yc beta compute host-group list](list.md) — Retrieves the list of host groups in the specified folder.

- [yc beta compute host-group list-access-bindings](list-access-bindings.md) — Lists access bindings for the host group.

- [yc beta compute host-group list-hosts](list-hosts.md) — Lists hosts that belongs to the specified host group.

- [yc beta compute host-group list-instances](list-instances.md) — Lists instances that belongs to the specified host group.

- [yc beta compute host-group list-operations](list-operations.md) — Lists operations for the specified host group.

- [yc beta compute host-group set-access-bindings](set-access-bindings.md) — Sets access bindings for the host group.

- [yc beta compute host-group update](update.md) — Updates the specified host group.

- [yc beta compute host-group update-access-bindings](update-access-bindings.md) — Updates access bindings for the host group.

- [yc beta compute host-group update-host](update-host.md) — Update host

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