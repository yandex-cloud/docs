---
editable: false
---

# yc managed-gitlab

Manage Gitlab resources.

#### Command Usage

Syntax:

`yc managed-gitlab <group>`

Aliases:

- `gitlab`

#### Command Tree

- [yc managed-gitlab instance](instance/index.md) — Manage Gitlab instances.

  - [yc managed-gitlab instance create](instance/create.md) — Create Gitlab instance

  - [yc managed-gitlab instance delete](instance/delete.md) — Delete the specified Gitlab instance

  - [yc managed-gitlab instance get](instance/get.md) — Show information about the specified gitlab instance

  - [yc managed-gitlab instance list](instance/list.md) — List Gitlab instances

  - [yc managed-gitlab instance start](instance/start.md) — Start the specified Gitlab instance

  - [yc managed-gitlab instance stop](instance/stop.md) — Stop the specified Gitlab instance

  - [yc managed-gitlab instance update](instance/update.md) — Update the specified Gitlab instance

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