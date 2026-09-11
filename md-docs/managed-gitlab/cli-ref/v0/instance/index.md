[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for GitLab](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > instance > Overview

# yc managed-gitlab v0 instance

Manage Gitlab instances.

#### Command Usage

Syntax:

`yc managed-gitlab v0 instance <command>`

Aliases:

- `instances`

#### Command Tree

- [yc managed-gitlab v0 instance create](create.md) — Create Gitlab instance

- [yc managed-gitlab v0 instance delete](delete.md) — Delete the specified Gitlab instance

- [yc managed-gitlab v0 instance get](get.md) — Show information about the specified gitlab instance

- [yc managed-gitlab v0 instance list](list.md) — List Gitlab instances

- [yc managed-gitlab v0 instance start](start.md) — Start the specified Gitlab instance

- [yc managed-gitlab v0 instance stop](stop.md) — Stop the specified Gitlab instance

- [yc managed-gitlab v0 instance update](update.md) — Update the specified Gitlab instance

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