[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [datatransfer](../index.md) > v0 > Overview

# yc datatransfer v0

Manage Data Transfer endpoints and transfers

#### Command Usage

Syntax:

`yc datatransfer v0 <group>`

#### Command Tree

- [yc datatransfer v0 endpoint](endpoint/index.md) — Manage endpoints

  - [yc datatransfer v0 endpoint delete](endpoint/delete.md) — Delete endpoint

  - [yc datatransfer v0 endpoint get](endpoint/get.md) — Get endpoint

  - [yc datatransfer v0 endpoint list](endpoint/list.md) — List endpoints in folder

- [yc datatransfer v0 transfer](transfer/index.md) — Manage transfers

  - [yc datatransfer v0 transfer activate](transfer/activate.md) — Activate transfer

  - [yc datatransfer v0 transfer create](transfer/create.md) — Create transfer

  - [yc datatransfer v0 transfer deactivate](transfer/deactivate.md) — Deactivate transfer

  - [yc datatransfer v0 transfer delete](transfer/delete.md) — Delete transfer

  - [yc datatransfer v0 transfer get](transfer/get.md) — Get transfer

  - [yc datatransfer v0 transfer list](transfer/list.md) — List transfers in folder

  - [yc datatransfer v0 transfer update](transfer/update.md) — Update transfer

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