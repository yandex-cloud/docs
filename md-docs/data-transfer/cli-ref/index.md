[Документация Yandex Cloud](../../index.md) > [Yandex Data Transfer](../index.md) > Справочник CLI (англ.) > Overview

# yc datatransfer

Manage Data Transfer endpoints and transfers

Command tree v0 is the default. Run `yc datatransfer <command>` or `yc datatransfer v0 <command>`.

#### Command Usage

Syntax:

`yc datatransfer <group>`

Aliases:

- `dt`

#### Command Tree

- [yc datatransfer v0](v0/index.md) — Manage Data Transfer endpoints and transfers



- [yc datatransfer endpoint](endpoint/index.md) — Manage endpoints

  - [yc datatransfer endpoint delete](endpoint/delete.md) — Delete endpoint

  - [yc datatransfer endpoint get](endpoint/get.md) — Get endpoint

  - [yc datatransfer endpoint list](endpoint/list.md) — List endpoints in folder

- [yc datatransfer transfer](transfer/index.md) — Manage transfers

  - [yc datatransfer transfer activate](transfer/activate.md) — Activate transfer

  - [yc datatransfer transfer create](transfer/create.md) — Create transfer

  - [yc datatransfer transfer deactivate](transfer/deactivate.md) — Deactivate transfer

  - [yc datatransfer transfer delete](transfer/delete.md) — Delete transfer

  - [yc datatransfer transfer get](transfer/get.md) — Get transfer

  - [yc datatransfer transfer list](transfer/list.md) — List transfers in folder

  - [yc datatransfer transfer update](transfer/update.md) — Update transfer

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