[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Logging](../../index.md) > [Справочник CLI (англ.)](../index.md) > v0 > Overview

# yc logging v0

Yandex Cloud Logging

#### Command Usage

Syntax:

`yc logging v0 <group|command>`

#### Command Tree

- [yc logging v0 read](read.md) — Read logs

- [yc logging v0 write](write.md) — Write to log

- [yc logging v0 group](group/index.md) — Manage log groups

  - [yc logging v0 group add-access-binding](group/add-access-binding.md) — Add access binding for the specified log group

  - [yc logging v0 group create](group/create.md) — Create log group

  - [yc logging v0 group delete](group/delete.md) — Delete log group

  - [yc logging v0 group get](group/get.md) — Show information about the specified log group

  - [yc logging v0 group list](group/list.md) — List log groups

  - [yc logging v0 group list-access-bindings](group/list-access-bindings.md) — List log group access bindings

  - [yc logging v0 group list-operations](group/list-operations.md) — List log group operations

  - [yc logging v0 group list-resources](group/list-resources.md) — List log group resources

  - [yc logging v0 group remove-access-binding](group/remove-access-binding.md) — Removes access binding from the specified log group

  - [yc logging v0 group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified log group and delete all existing access bindings if there were any

  - [yc logging v0 group stats](group/stats.md) — Show consumed resources for log group(s)

  - [yc logging v0 group update](group/update.md) — Update log group

- [yc logging v0 sink](sink/index.md) — Manage log groups

  - [yc logging v0 sink add-access-binding](sink/add-access-binding.md) — Add access binding for the specified sink

  - [yc logging v0 sink create](sink/create.md) — Create log sink

  - [yc logging v0 sink delete](sink/delete.md) — Delete log sink

  - [yc logging v0 sink get](sink/get.md) — Show information about the specified logging sink

  - [yc logging v0 sink list](sink/list.md) — List log sinks

  - [yc logging v0 sink list-access-bindings](sink/list-access-bindings.md) — List log group access bindings

  - [yc logging v0 sink list-operations](sink/list-operations.md) — List sink operations

  - [yc logging v0 sink remove-access-binding](sink/remove-access-binding.md) — Rempve access binding from the specified sink

  - [yc logging v0 sink set-access-bindings](sink/set-access-bindings.md) — Set access bindings for the specified log group and delete all existing access bindings if there were any

  - [yc logging v0 sink update](sink/update.md) — Update log sink

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