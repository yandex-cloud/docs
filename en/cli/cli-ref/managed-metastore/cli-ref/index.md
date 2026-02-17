---
editable: false
---

# yc managed-metastore

Manage Metastore clusters.

#### Command Usage

Syntax:

`yc managed-metastore <group>`

Aliases:

- `metastore`

#### Command Tree

- [yc managed-metastore cluster](cluster/index.md) — Manage Metastore clusters

  - [yc managed-metastore cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Metastore cluster

  - [yc managed-metastore cluster create](cluster/create.md) — Create Metastore cluster

  - [yc managed-metastore cluster delete](cluster/delete.md) — Delete the specified Metastore cluster

  - [yc managed-metastore cluster export-data](cluster/export-data.md) — Export data from the specified Metastore cluster

  - [yc managed-metastore cluster get](cluster/get.md) — Show information about the specified Metastore cluster

  - [yc managed-metastore cluster import-data](cluster/import-data.md) — Import data to the specified Metastore cluster

  - [yc managed-metastore cluster list](cluster/list.md) — List Metastore clusters

  - [yc managed-metastore cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Metastore cluster

  - [yc managed-metastore cluster list-operations](cluster/list-operations.md) — List operations for the specified Metastore cluster

  - [yc managed-metastore cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Metastore cluster

  - [yc managed-metastore cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Metastore cluster and delete all existing access bindings if there were any

  - [yc managed-metastore cluster start](cluster/start.md) — Start the specified Metastore cluster

  - [yc managed-metastore cluster stop](cluster/stop.md) — Stop the specified Metastore cluster

  - [yc managed-metastore cluster update](cluster/update.md) — Update the specified Metastore cluster

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