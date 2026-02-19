---
editable: false
noIndex: true
---

# yc beta vpc route-table

A set of methods for managing RouteTable resources.

#### Command Usage

Syntax:

`yc beta vpc route-table <command>`

#### Command Tree

- [yc beta vpc route-table create](create.md) — Creates a route table in the specified folder and network.

- [yc beta vpc route-table delete](delete.md) — Deletes the specified route table.

- [yc beta vpc route-table get](get.md) — Returns the specified RouteTable resource.

- [yc beta vpc route-table list](list.md) — Retrieves the list of RouteTable resources in the specified folder.

- [yc beta vpc route-table list-operations](list-operations.md) — List operations for the specified route table.

- [yc beta vpc route-table move](move.md) — Move route table to another folder.

- [yc beta vpc route-table update](update.md) — Updates the specified route table.

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