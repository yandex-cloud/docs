[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for YTsaurus](../index.md) > Справочник YC CLI (англ.) > Overview

# yc managed-ytsaurus

Manage YTsaurus clusters.

Command tree v0 is the default. Run `yc managed-ytsaurus <command>` or `yc managed-ytsaurus v0 <command>`.

#### Command Usage

Syntax:

`yc managed-ytsaurus <group>`

Aliases:

- `ytsaurus`

#### Command Tree

- [yc managed-ytsaurus cluster](cluster/index.md) — Manage YTsaurus clusters.

  - [yc managed-ytsaurus cluster delete](cluster/delete.md) — Delete the specified YTsaurus clusters.

  - [yc managed-ytsaurus cluster get](cluster/get.md) — Show information about the specified YTsaurus clusters.

  - [yc managed-ytsaurus cluster get-configuration](cluster/get-configuration.md) — Get configuration of the specified YTsaurus clusters.

  - [yc managed-ytsaurus cluster list](cluster/list.md) — List YTsaurus clusters.

  - [yc managed-ytsaurus cluster start](cluster/start.md) — Start the specified YTsaurus clusters.

  - [yc managed-ytsaurus cluster stop](cluster/stop.md) — Stop the specified YTsaurus clusters.

- [yc managed-ytsaurus v0](v0/index.md) — Manage YTsaurus clusters.



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