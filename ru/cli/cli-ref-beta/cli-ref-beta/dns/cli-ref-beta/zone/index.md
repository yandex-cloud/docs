---
editable: false
noIndex: true
---

# yc beta dns zone

A set of methods for managing DNS zones.

#### Command Usage

Syntax:

`yc beta dns zone <command>`

#### Command Tree

- [yc beta dns zone create](create.md) — Creates a DNS zone in the specified folder.

- [yc beta dns zone delete](delete.md) — Deletes the specified DNS zone.

- [yc beta dns zone get](get.md) — Returns the specified DNS zone.

- [yc beta dns zone get-record-set](get-record-set.md) — Returns the specified record set.

- [yc beta dns zone list](list.md) — Retrieves the list of DNS zones in the specified folder.

- [yc beta dns zone list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified DNS zone.

- [yc beta dns zone list-operations](list-operations.md) — Lists operations for the specified DNS zone.

- [yc beta dns zone list-record-sets](list-record-sets.md) — Retrieves the list of record sets in the specified folder.

- [yc beta dns zone move](move.md) — Moves the specified DNS zone to another folder.

- [yc beta dns zone set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified DNS zone.

- [yc beta dns zone update](update.md) — Updates the specified DNS zone.

- [yc beta dns zone update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified DNS zone.

- [yc beta dns zone update-private-networks](update-private-networks.md) — Atomically updates zone private networks

- [yc beta dns zone update-record-sets](update-record-sets.md) — Method with strict control for changing zone state. Returns error when:

- [yc beta dns zone upsert-record-sets](upsert-record-sets.md) — Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist.

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