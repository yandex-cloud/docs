[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [cloudrouter](../index.md) > v2 > Overview

# yc cloudrouter v2

[PREVIEW] Manage Cloud Router resources

#### Command Usage

Syntax:

`yc cloudrouter v2 <group>`

#### Command Tree

- [yc cloudrouter v2 peering](peering/index.md) — A set of methods for managing peering resources.

  - [yc cloudrouter v2 peering create](peering/create.md) — Creates a peering in the specified folder.

  - [yc cloudrouter v2 peering delete](peering/delete.md) — Deletes the specified peering.

  - [yc cloudrouter v2 peering get](peering/get.md) — Returns the specified peering.

  - [yc cloudrouter v2 peering list](peering/list.md) — Retrieves the list of peerings in the specified folder.

  - [yc cloudrouter v2 peering list-operations](peering/list-operations.md) — Lists operations for the specified peering.

  - [yc cloudrouter v2 peering move](peering/move.md) — Moves the specified peering to another folder.

  - [yc cloudrouter v2 peering update](peering/update.md) — Updates the specified peering.

- [yc cloudrouter v2 routing-instance](routing-instance/index.md) — A set of methods for managing routing instance resources.

  - [yc cloudrouter v2 routing-instance create](routing-instance/create.md) — Creates a routing instance in the specified folder.

  - [yc cloudrouter v2 routing-instance delete](routing-instance/delete.md) — Deletes the specified routing instance.

  - [yc cloudrouter v2 routing-instance get](routing-instance/get.md) — Returns the specified routing instance.

  - [yc cloudrouter v2 routing-instance list](routing-instance/list.md) — Retrieves the list of routing instances in the specified folder.

  - [yc cloudrouter v2 routing-instance list-operations](routing-instance/list-operations.md) — Lists operations for the specified routing instance.

  - [yc cloudrouter v2 routing-instance move](routing-instance/move.md) — Moves the specified routing instance to another folder.

  - [yc cloudrouter v2 routing-instance update](routing-instance/update.md) — Updates the specified routing instance.

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

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
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