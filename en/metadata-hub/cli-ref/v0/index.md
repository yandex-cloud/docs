---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-metastore/cli-ref/v0/
---

# yc managed-metastore v0

Manage Metastore clusters.

#### Command Usage

Syntax:

`yc managed-metastore v0 <group>`

#### Command Tree

- [yc managed-metastore v0 change-freeze](change-freeze/index.md) — Manage change freezes.

  - [yc managed-metastore v0 change-freeze create](change-freeze/create.md) — Create a change freeze for the specified resource.

  - [yc managed-metastore v0 change-freeze get](change-freeze/get.md) — Show the specified change freeze.

  - [yc managed-metastore v0 change-freeze get-limits](change-freeze/get-limits.md) — Show change freeze limits for the specified resource.

  - [yc managed-metastore v0 change-freeze list](change-freeze/list.md) — List change freezes.

  - [yc managed-metastore v0 change-freeze terminate](change-freeze/terminate.md) — Terminate the specified change freeze.

- [yc managed-metastore v0 cluster](cluster/index.md) — Manage Metastore clusters

  - [yc managed-metastore v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Metastore cluster

  - [yc managed-metastore v0 cluster create](cluster/create.md) — Create Metastore cluster

  - [yc managed-metastore v0 cluster delete](cluster/delete.md) — Delete the specified Metastore cluster

  - [yc managed-metastore v0 cluster export-data](cluster/export-data.md) — Export data from the specified Metastore cluster

  - [yc managed-metastore v0 cluster get](cluster/get.md) — Show information about the specified Metastore cluster

  - [yc managed-metastore v0 cluster import-data](cluster/import-data.md) — Import data to the specified Metastore cluster

  - [yc managed-metastore v0 cluster list](cluster/list.md) — List Metastore clusters

  - [yc managed-metastore v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Metastore cluster

  - [yc managed-metastore v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified Metastore cluster

  - [yc managed-metastore v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Metastore cluster

  - [yc managed-metastore v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Metastore cluster and delete all existing access bindings if there were any

  - [yc managed-metastore v0 cluster start](cluster/start.md) — Start the specified Metastore cluster

  - [yc managed-metastore v0 cluster stop](cluster/stop.md) — Stop the specified Metastore cluster

  - [yc managed-metastore v0 cluster update](cluster/update.md) — Update the specified Metastore cluster

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#