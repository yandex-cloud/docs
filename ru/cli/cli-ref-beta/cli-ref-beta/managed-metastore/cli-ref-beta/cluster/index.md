---
editable: false
noIndex: true
---

# yc beta managed-metastore cluster

A set of methods for managing Metastore Cluster resources.

#### Command Usage

Syntax:

`yc beta managed-metastore cluster <command>`

#### Command Tree

- [yc beta managed-metastore cluster create](create.md) — Creates a Metastore Cluster.

- [yc beta managed-metastore cluster delete](delete.md) — Deletes the specified Metastore Cluster.

- [yc beta managed-metastore cluster export-data](export-data.md) — Exports data from the specified Metastore Cluster.

- [yc beta managed-metastore cluster get](get.md) — Returns the specified Metastore Cluster.

- [yc beta managed-metastore cluster import-data](import-data.md) — Imports data to the specified Metastore Cluster.

- [yc beta managed-metastore cluster list](list.md) — Retrieves a list of Metastore Clusters.

- [yc beta managed-metastore cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified Metastore cluster.

- [yc beta managed-metastore cluster list-operations](list-operations.md) — Retrieves the list of Operation resources for the specified Hive Metastore Cluster.

- [yc beta managed-metastore cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified Metastore cluster.

- [yc beta managed-metastore cluster start](start.md) — Starts the specified Metastore Cluster.

- [yc beta managed-metastore cluster stop](stop.md) — Stops the specified Metastore Cluster.

- [yc beta managed-metastore cluster update](update.md) — Updates the configuration of the specified Metastore Cluster.

- [yc beta managed-metastore cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Metastore cluster.

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