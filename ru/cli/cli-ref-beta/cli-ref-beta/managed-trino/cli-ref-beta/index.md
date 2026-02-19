---
editable: false
noIndex: true
---

# yc beta managed-trino

Manage Trino clusters

#### Command Usage

Syntax:

`yc beta managed-trino <group>`

#### Command Tree

- [yc beta managed-trino catalog](catalog/index.md) — A set of methods for managing Trino Cluster Catalog resources.

  - [yc beta managed-trino catalog create](catalog/create.md) — Creates a new Trino Catalog.

  - [yc beta managed-trino catalog delete](catalog/delete.md) — Deletes the specified Trino Catalog.

  - [yc beta managed-trino catalog get](catalog/get.md) — Returns the specified Trino Catalog resource.

  - [yc beta managed-trino catalog list](catalog/list.md) — Retrieves a list of Trino Catalog resources.

  - [yc beta managed-trino catalog update](catalog/update.md) — Updates the specified Trino Catalog.

- [yc beta managed-trino cluster](cluster/index.md) — A set of methods for managing Trino Cluster resources.

  - [yc beta managed-trino cluster create](cluster/create.md) — Creates a Trino Cluster resource.

  - [yc beta managed-trino cluster delete](cluster/delete.md) — Deletes the specified Trino Cluster resource.

  - [yc beta managed-trino cluster get](cluster/get.md) — Returns the specified Trino Cluster resource.

  - [yc beta managed-trino cluster list](cluster/list.md) — Retrieves a list of Trino Cluster resources.

  - [yc beta managed-trino cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Trino cluster.

  - [yc beta managed-trino cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.

  - [yc beta managed-trino cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Trino cluster.

  - [yc beta managed-trino cluster start](cluster/start.md) — Start the specified Trino Cluster resource.

  - [yc beta managed-trino cluster stop](cluster/stop.md) — Stops the specified Trino Cluster resource.

  - [yc beta managed-trino cluster update](cluster/update.md) — Updates configuration of the specified Trino cluster.

  - [yc beta managed-trino cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Trino cluster.

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