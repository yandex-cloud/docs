---
editable: false
noIndex: true
---

# yc beta managed-metastore

Manage Metastore clusters

#### Command Usage

Syntax:

`yc beta managed-metastore <group>`

#### Command Tree

- [yc beta managed-metastore cluster](cluster/index.md) — A set of methods for managing Metastore Cluster resources.

  - [yc beta managed-metastore cluster create](cluster/create.md) — Creates a Metastore Cluster.

  - [yc beta managed-metastore cluster delete](cluster/delete.md) — Deletes the specified Metastore Cluster.

  - [yc beta managed-metastore cluster export-data](cluster/export-data.md) — Exports data from the specified Metastore Cluster.

  - [yc beta managed-metastore cluster get](cluster/get.md) — Returns the specified Metastore Cluster.

  - [yc beta managed-metastore cluster import-data](cluster/import-data.md) — Imports data to the specified Metastore Cluster.

  - [yc beta managed-metastore cluster list](cluster/list.md) — Retrieves a list of Metastore Clusters.

  - [yc beta managed-metastore cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Metastore cluster.

  - [yc beta managed-metastore cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified Hive Metastore Cluster.

  - [yc beta managed-metastore cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Metastore cluster.

  - [yc beta managed-metastore cluster start](cluster/start.md) — Starts the specified Metastore Cluster.

  - [yc beta managed-metastore cluster stop](cluster/stop.md) — Stops the specified Metastore Cluster.

  - [yc beta managed-metastore cluster update](cluster/update.md) — Updates the configuration of the specified Metastore Cluster.

  - [yc beta managed-metastore cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Metastore cluster.

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