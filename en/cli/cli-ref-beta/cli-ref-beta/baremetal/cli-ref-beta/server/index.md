---
editable: false
noIndex: true
---

# yc beta baremetal server

A set of methods for managing Server resources.

#### Command Usage

Syntax:

`yc beta baremetal server <command>`

#### Command Tree

- [yc beta baremetal server batch-create](batch-create.md) — Creates multiple servers in the specified folder.

- [yc beta baremetal server create](create.md) — Creates a server in the specified folder.

- [yc beta baremetal server get](get.md) — Returns the specific Server resource.

- [yc beta baremetal server list](list.md) — Retrieves the list of Server resources in the specified folder.

- [yc beta baremetal server list-operations](list-operations.md) — Lists operations for the specified server.

- [yc beta baremetal server power-off](power-off.md) — (-- api-linter: yc::1702::method-verb-prefix=disabled

- [yc beta baremetal server power-on](power-on.md) — (-- api-linter: yc::1702::method-verb-prefix=disabled

- [yc beta baremetal server reboot](reboot.md) — (-- api-linter: yc::1702::method-verb-prefix=disabled

- [yc beta baremetal server reinstall](reinstall.md) — (-- api-linter: yc::1702::method-verb-prefix=disabled

- [yc beta baremetal server start-prolongation](start-prolongation.md) — Starts prolongation of the specified server.

- [yc beta baremetal server stop-prolongation](stop-prolongation.md) — Stops prolongation of the specified server.

- [yc beta baremetal server update](update.md) — Updates the specified server.

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