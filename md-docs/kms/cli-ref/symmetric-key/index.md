[Документация Yandex Cloud](../../../index.md) > [Yandex Key Management Service](../../index.md) > [Справочник CLI (англ.)](../index.md) > symmetric-key > Overview

# yc kms symmetric-key

Manage symmetric keys

#### Command Usage

Syntax:

`yc kms symmetric-key <command>`

Aliases:

- `symmetric-keys`

#### Command Tree

- [yc kms symmetric-key add-access-binding](add-access-binding.md) — Add access binding for the specified symmetric key

- [yc kms symmetric-key cancel-version-destruction](cancel-version-destruction.md) — Cancel destruction of the scheduled for destruction symmetric key version

- [yc kms symmetric-key create](create.md) — Create symmetric key

- [yc kms symmetric-key delete](delete.md) — Delete the specified symmetric key

- [yc kms symmetric-key get](get.md) — Show information about the specified symmetric key

- [yc kms symmetric-key list](list.md) — List symmetric keys of the specified folder

- [yc kms symmetric-key list-access-bindings](list-access-bindings.md) — List access bindings for the specified symmetric key

- [yc kms symmetric-key list-operations](list-operations.md) — List operations for the specified symmetric key

- [yc kms symmetric-key list-versions](list-versions.md) — List versions of the specified symmetric key

- [yc kms symmetric-key remove-access-binding](remove-access-binding.md) — Remove access binding for the specified symmetric key

- [yc kms symmetric-key rotate](rotate.md) — Rotate the specified symmetric key: creates a new key version and makes it the primary version

- [yc kms symmetric-key schedule-version-destruction](schedule-version-destruction.md) — Schedule destruction of the specified symmetric key version

- [yc kms symmetric-key set-access-bindings](set-access-bindings.md) — Set access bindings for the specified symmetric key and delete all existing access bindings if there were any

- [yc kms symmetric-key set-primary-version](set-primary-version.md) — Set primary version of the specified symmetric key

- [yc kms symmetric-key update](update.md) — Update the specified symmetric key

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