---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/ydb/cli-ref/v0/backup/
---

# yc ydb v0 backup

Manage YDB backups.

#### Command Usage

Syntax:

`yc ydb v0 backup <command>`

#### Command Tree

- [yc ydb v0 backup add-access-binding](add-access-binding.md) — Add access binding for the specified YDB backup.

- [yc ydb v0 backup delete](delete.md) — Delete the specified YDB backups.

- [yc ydb v0 backup get](get.md) — Get information about the specified YDB backup.

- [yc ydb v0 backup list](list.md) — List YDB backups in a folder.

- [yc ydb v0 backup list-access-bindings](list-access-bindings.md) — List access bindings for the specified YDB backup.

- [yc ydb v0 backup remove-access-binding](remove-access-binding.md) — Remove access binding for the specified YDB backup.

- [yc ydb v0 backup set-access-bindings](set-access-bindings.md) — Set access bindings for the specified YDB backup and delete all existing access bindings if there were any.

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