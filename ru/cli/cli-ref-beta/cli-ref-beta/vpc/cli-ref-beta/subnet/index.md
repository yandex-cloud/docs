---
editable: false
noIndex: true
---

# yc beta vpc subnet

A set of methods for managing Subnet resources.

#### Command Usage

Syntax:

`yc beta vpc subnet <command>`

#### Command Tree

- [yc beta vpc subnet add-cidr-blocks](add-cidr-blocks.md) — Adds CIDR blocks to the specified subnet.

- [yc beta vpc subnet create](create.md) — Creates a subnet in the specified folder and network.

- [yc beta vpc subnet delete](delete.md) — Deletes the specified subnet.

- [yc beta vpc subnet get](get.md) — Returns the specified Subnet resource.

- [yc beta vpc subnet list](list.md) — Retrieves the list of Subnet resources in the specified folder.

- [yc beta vpc subnet list-operations](list-operations.md) — List operations for the specified subnet.

- [yc beta vpc subnet list-used-addresses](list-used-addresses.md) — List used addresses in specified subnet.

- [yc beta vpc subnet move](move.md) — Move subnet to another folder.

- [yc beta vpc subnet relocate](relocate.md) — 

- [yc beta vpc subnet remove-cidr-blocks](remove-cidr-blocks.md) — Removes CIDR blocks from the specified subnet.

- [yc beta vpc subnet update](update.md) — Updates the specified subnet.

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