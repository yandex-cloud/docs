[Документация Yandex Cloud](../../../../index.md) > [Интерфейс командной строки](../../../index.md) > [Справочник (англ.)](../../index.md) > lockbox > Overview

# yc lockbox

Manage Yandex Lockbox resources

Command tree v0 is the default. Run `yc lockbox <command>` or `yc lockbox v0 <command>`.

#### Command Usage

Syntax:

`yc lockbox <group>`

#### Command Tree

- [yc lockbox payload](payload/index.md) — Access secret payload

  - [yc lockbox payload get](payload/get.md) — Get payload of the specified secret

- [yc lockbox secret](secret/index.md) — Manage secrets

  - [yc lockbox secret activate](secret/activate.md) — Activate the specified secret

  - [yc lockbox secret add-access-binding](secret/add-access-binding.md) — Add access binding for the specified secret

  - [yc lockbox secret add-version](secret/add-version.md) — Add new payload version for the specified secret based on an existing one

  - [yc lockbox secret cancel-version-destruction](secret/cancel-version-destruction.md) — Cancel destruction of the specified secret version

  - [yc lockbox secret create](secret/create.md) — Create a secret

  - [yc lockbox secret deactivate](secret/deactivate.md) — Deactivate the specified secret

  - [yc lockbox secret delete](secret/delete.md) — Delete the specified secret

  - [yc lockbox secret get](secret/get.md) — Show information about the specified secret

  - [yc lockbox secret list](secret/list.md) — List secrets for the specified folder

  - [yc lockbox secret list-access-bindings](secret/list-access-bindings.md) — List access bindings for the specified secret

  - [yc lockbox secret list-operations](secret/list-operations.md) — List operations for the specified secret

  - [yc lockbox secret list-versions](secret/list-versions.md) — List versions for the specified secret

  - [yc lockbox secret remove-access-binding](secret/remove-access-binding.md) — Remove access binding for the specified secret

  - [yc lockbox secret schedule-version-destruction](secret/schedule-version-destruction.md) — Schedule destruction of the specified secret version

  - [yc lockbox secret set-access-bindings](secret/set-access-bindings.md) — Set access bindings for the specified secret and delete all existing access bindings if there were any

  - [yc lockbox secret update](secret/update.md) — Update the specified secret

- [yc lockbox v0](v0/index.md) — Manage Yandex Lockbox resources



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