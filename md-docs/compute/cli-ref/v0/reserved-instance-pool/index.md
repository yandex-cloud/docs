[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > reserved-instance-pool > Overview

# yc compute v0 reserved-instance-pool

Manage reserved instance pools

#### Command Usage

Syntax:

`yc compute v0 reserved-instance-pool <command>`

Aliases:

- `reserved-instance-pools`

- `pool`

- `pools`

#### Command Tree

- [yc compute v0 reserved-instance-pool create](create.md) — Create a reserved instance pool

- [yc compute v0 reserved-instance-pool delete](delete.md) — Delete the specified reserved instance pool

- [yc compute v0 reserved-instance-pool get](get.md) — Show information about the specified reserved instance pool

- [yc compute v0 reserved-instance-pool list](list.md) — List reserved instance pools

- [yc compute v0 reserved-instance-pool list-instances](list-instances.md) — List instances of the specified reserved instance pool

- [yc compute v0 reserved-instance-pool list-operations](list-operations.md) — List operations of the specified reserved instance pool

- [yc compute v0 reserved-instance-pool update](update.md) — Update the specified reserved instance pool

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