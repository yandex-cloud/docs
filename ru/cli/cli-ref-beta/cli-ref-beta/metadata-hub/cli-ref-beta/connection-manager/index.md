---
editable: false
noIndex: true
---

# yc beta metadata-hub connection-manager



#### Command Usage

Syntax:

`yc beta metadata-hub connection-manager <group>`

#### Command Tree

- [yc beta metadata-hub connection-manager connection](connection/index.md) — A set of methods for managing Connection resources.

  - [yc beta metadata-hub connection-manager connection create](connection/create.md) — Creates a connection.

  - [yc beta metadata-hub connection-manager connection delete](connection/delete.md) — Deletes the specified connection.

  - [yc beta metadata-hub connection-manager connection get](connection/get.md) — Returns the specified connection.

  - [yc beta metadata-hub connection-manager connection list](connection/list.md) — Retrieves the list of connections in the specified folder.

  - [yc beta metadata-hub connection-manager connection list-operations](connection/list-operations.md) — Lists operations for the specified connection.

  - [yc beta metadata-hub connection-manager connection resolve-cluster](connection/resolve-cluster.md) — Returns the connection with the resolved cluster; that is,

  - [yc beta metadata-hub connection-manager connection update](connection/update.md) — Updates the specified connection.

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