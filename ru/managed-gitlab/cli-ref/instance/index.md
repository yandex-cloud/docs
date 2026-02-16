---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-gitlab/cli-ref/instance/index.md
---

# yc managed-gitlab instance

Manage Gitlab instances.

#### Command Usage

Syntax:

`yc managed-gitlab instance <command>`

Aliases:

- `instances`

#### Command Tree

- [yc managed-gitlab instance create](create.md) — Create Gitlab instance

- [yc managed-gitlab instance delete](delete.md) — Delete the specified Gitlab instance

- [yc managed-gitlab instance get](get.md) — Show information about the specified gitlab instance

- [yc managed-gitlab instance list](list.md) — List Gitlab instances

- [yc managed-gitlab instance start](start.md) — Start the specified Gitlab instance

- [yc managed-gitlab instance stop](stop.md) — Stop the specified Gitlab instance

- [yc managed-gitlab instance update](update.md) — Update the specified Gitlab instance

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