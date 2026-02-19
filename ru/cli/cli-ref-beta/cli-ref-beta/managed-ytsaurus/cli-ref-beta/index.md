---
editable: false
noIndex: true
---

# yc beta managed-ytsaurus

Manage YTsaurus clusters

#### Command Usage

Syntax:

`yc beta managed-ytsaurus <group>`

#### Command Tree

- [yc beta managed-ytsaurus cluster](cluster/index.md) — A set of methods for managing Cluster resources.

  - [yc beta managed-ytsaurus cluster create](cluster/create.md) — Creates a cluster in the specified folder.

  - [yc beta managed-ytsaurus cluster delete](cluster/delete.md) — Deletes the specified cluster.

  - [yc beta managed-ytsaurus cluster get](cluster/get.md) — Returns the specified cluster.

  - [yc beta managed-ytsaurus cluster list](cluster/list.md) — Retrieves the list of clusters in the specified folder.

  - [yc beta managed-ytsaurus cluster start](cluster/start.md) — Starts the specified cluster.

  - [yc beta managed-ytsaurus cluster stop](cluster/stop.md) — Stops the specified cluster.

  - [yc beta managed-ytsaurus cluster update](cluster/update.md) — Updates the specified cluster.

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