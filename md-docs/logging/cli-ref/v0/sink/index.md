[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Logging](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > sink > Overview

# yc logging v0 sink

Manage log groups

#### Command Usage

Syntax:

`yc logging v0 sink <command>`

#### Command Tree

- [yc logging v0 sink add-access-binding](add-access-binding.md) — Add access binding for the specified sink

- [yc logging v0 sink create](create.md) — Create log sink

- [yc logging v0 sink delete](delete.md) — Delete log sink

- [yc logging v0 sink get](get.md) — Show information about the specified logging sink

- [yc logging v0 sink list](list.md) — List log sinks

- [yc logging v0 sink list-access-bindings](list-access-bindings.md) — List log group access bindings

- [yc logging v0 sink list-operations](list-operations.md) — List sink operations

- [yc logging v0 sink remove-access-binding](remove-access-binding.md) — Rempve access binding from the specified sink

- [yc logging v0 sink set-access-bindings](set-access-bindings.md) — Set access bindings for the specified log group and delete all existing access bindings if there were any

- [yc logging v0 sink update](update.md) — Update log sink

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