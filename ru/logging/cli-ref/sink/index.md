---
editable: false
sourcePath: en/_cli-ref/cli-ref/logging/cli-ref/sink/index.md
---

# yc logging sink

Manage log groups

#### Command Usage

Syntax:

`yc logging sink <command>`

#### Command Tree

- [yc logging sink add-access-binding](add-access-binding.md) — Add access binding for the specified sink

- [yc logging sink create](create.md) — Create log sink

- [yc logging sink delete](delete.md) — Delete log sink

- [yc logging sink get](get.md) — Show information about the specified logging sink

- [yc logging sink list](list.md) — List log sinks

- [yc logging sink list-access-bindings](list-access-bindings.md) — List log group access bindings

- [yc logging sink list-operations](list-operations.md) — List sink operations

- [yc logging sink remove-access-binding](remove-access-binding.md) — Rempve access binding from the specified sink

- [yc logging sink set-access-bindings](set-access-bindings.md) — Set access bindings for the specified log group and delete all existing access bindings if there were any

- [yc logging sink update](update.md) — Update log sink

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