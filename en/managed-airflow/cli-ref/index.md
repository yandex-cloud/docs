---
editable: false
---

# yc managed-airflow

Manage Airflow clusters.

#### Command Usage

Syntax:

`yc managed-airflow <group>`

Aliases:

- `airflow`

#### Command Tree

- [yc managed-airflow cluster](cluster/index.md) — Manage Airflow clusters.

  - [yc managed-airflow cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Airflow cluster

  - [yc managed-airflow cluster create](cluster/create.md) — Create Airflow cluster

  - [yc managed-airflow cluster delete](cluster/delete.md) — Delete the specified Airflow cluster

  - [yc managed-airflow cluster get](cluster/get.md) — Show information about the specified Airflow cluster

  - [yc managed-airflow cluster list](cluster/list.md) — List Airflow clusters

  - [yc managed-airflow cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Airflow cluster

  - [yc managed-airflow cluster list-operations](cluster/list-operations.md) — List operations for the specified Airflow cluster

  - [yc managed-airflow cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Airflow cluster

  - [yc managed-airflow cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Airflow cluster and delete all existing access bindings if there were any

  - [yc managed-airflow cluster start](cluster/start.md) — Start the specified Airflow cluster

  - [yc managed-airflow cluster stop](cluster/stop.md) — Stop the specified Airflow cluster

  - [yc managed-airflow cluster update](cluster/update.md) — Update the specified Airflow cluster

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