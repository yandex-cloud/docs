---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/audit-trails/cli-ref/v0/
editable: false
---

# yc audit-trails v0

Manage Audit Trails resources

#### Command Usage

Syntax:

`yc audit-trails v0 <group>`

#### Command Tree

- [yc audit-trails v0 trail](trail/index.md) — Manage trails

  - [yc audit-trails v0 trail add-access-binding](trail/add-access-binding.md) — Add access binding for the specified trail

  - [yc audit-trails v0 trail create](trail/create.md) — Create the specified trail

  - [yc audit-trails v0 trail delete](trail/delete.md) — Delete the specified trail

  - [yc audit-trails v0 trail get](trail/get.md) — Show information about the specified trail

  - [yc audit-trails v0 trail list](trail/list.md) — List trails

  - [yc audit-trails v0 trail list-access-bindings](trail/list-access-bindings.md) — List access bindings for the specified trail

  - [yc audit-trails v0 trail list-operations](trail/list-operations.md) — List operations for the specified trail

  - [yc audit-trails v0 trail remove-access-binding](trail/remove-access-binding.md) — Remove access binding for the specified trail

  - [yc audit-trails v0 trail set-access-bindings](trail/set-access-bindings.md) — Set access bindings for the specified trail and delete all existing access bindings if there were any

  - [yc audit-trails v0 trail update](trail/update.md) — Update the specified trail

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
