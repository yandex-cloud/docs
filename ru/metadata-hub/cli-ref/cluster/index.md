---
editable: false
---

# yc managed-metastore cluster

Manage Metastore clusters

#### Command Usage

Syntax:

`yc managed-metastore cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-metastore cluster add-access-binding](add-access-binding.md) — Add access binding for the specified Metastore cluster

- [yc managed-metastore cluster create](create.md) — Create Metastore cluster

- [yc managed-metastore cluster delete](delete.md) — Delete the specified Metastore cluster

- [yc managed-metastore cluster export-data](export-data.md) — Export data from the specified Metastore cluster

- [yc managed-metastore cluster get](get.md) — Show information about the specified Metastore cluster

- [yc managed-metastore cluster import-data](import-data.md) — Import data to the specified Metastore cluster

- [yc managed-metastore cluster list](list.md) — List Metastore clusters

- [yc managed-metastore cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified Metastore cluster

- [yc managed-metastore cluster list-operations](list-operations.md) — List operations for the specified Metastore cluster

- [yc managed-metastore cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Metastore cluster

- [yc managed-metastore cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Metastore cluster and delete all existing access bindings if there were any

- [yc managed-metastore cluster start](start.md) — Start the specified Metastore cluster

- [yc managed-metastore cluster stop](stop.md) — Stop the specified Metastore cluster

- [yc managed-metastore cluster update](update.md) — Update the specified Metastore cluster

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