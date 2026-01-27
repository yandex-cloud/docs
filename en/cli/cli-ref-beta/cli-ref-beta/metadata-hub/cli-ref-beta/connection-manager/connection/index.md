---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/metadata-hub/cli-ref-beta/connection-manager/connection/index.md
---

# yc beta metadata-hub connection-manager connection

A set of methods for managing Connection resources.

#### Command Usage

Syntax:

`yc beta metadata-hub connection-manager connection <command>`

#### Command Tree

- [yc beta metadata-hub connection-manager connection create](create.md) — Creates connection.

- [yc beta metadata-hub connection-manager connection delete](delete.md) — Delete specified connection.

- [yc beta metadata-hub connection-manager connection get](get.md) — Returns connection.

- [yc beta metadata-hub connection-manager connection list](list.md) — List connections in specified folder.

- [yc beta metadata-hub connection-manager connection list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified connection.

- [yc beta metadata-hub connection-manager connection resolve-cluster](resolve-cluster.md) — Returns the connection with the resolved cluster; that is,

- [yc beta metadata-hub connection-manager connection update](update.md) — Updates specified connection.

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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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