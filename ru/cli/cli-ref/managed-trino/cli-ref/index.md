---
editable: false
---

# yc managed-trino

Manage Trino clusters.

#### Command Usage

Syntax:

`yc managed-trino <group>`

Aliases:

- `trino`

#### Command Tree

- [yc managed-trino catalog](catalog/index.md) — Manage Trino catalogs

  - [yc managed-trino catalog delete](catalog/delete.md) — Delete the specified Trino catalog

  - [yc managed-trino catalog get](catalog/get.md) — Show information about the specified Trino catalog

  - [yc managed-trino catalog list](catalog/list.md) — List Trino catalogs

- [yc managed-trino cluster](cluster/index.md) — Manage Trino clusters

  - [yc managed-trino cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Trino cluster

  - [yc managed-trino cluster create](cluster/create.md) — Create Trino cluster

  - [yc managed-trino cluster delete](cluster/delete.md) — Delete the specified Trino cluster

  - [yc managed-trino cluster get](cluster/get.md) — Show information about the specified Trino cluster

  - [yc managed-trino cluster get-access-control](cluster/get-access-control.md) — Get Trino cluster access control configuration

  - [yc managed-trino cluster get-resource-groups](cluster/get-resource-groups.md) — Get Trino cluster resource groups configuration

  - [yc managed-trino cluster list](cluster/list.md) — List Trino clusters

  - [yc managed-trino cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Trino cluster

  - [yc managed-trino cluster list-operations](cluster/list-operations.md) — List operations for the specified Trino cluster

  - [yc managed-trino cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Trino cluster

  - [yc managed-trino cluster remove-access-control](cluster/remove-access-control.md) — Remove access control from Trino cluster configuration

  - [yc managed-trino cluster remove-resource-groups](cluster/remove-resource-groups.md) — Remove resource groups from Trino cluster configuration

  - [yc managed-trino cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Trino cluster and delete all existing access bindings if there were any

  - [yc managed-trino cluster set-access-control](cluster/set-access-control.md) — Set Trino cluster access control configuration

  - [yc managed-trino cluster set-resource-groups](cluster/set-resource-groups.md) — Set Trino cluster resource groups configuration from YAML file

  - [yc managed-trino cluster start](cluster/start.md) — Start the specified Trino cluster

  - [yc managed-trino cluster stop](cluster/stop.md) — Stop the specified Trino cluster

  - [yc managed-trino cluster update](cluster/update.md) — Update the specified Trino cluster

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#