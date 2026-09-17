---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/desktops/cli-ref/
---

# yc desktops

Manage Desktop resources

Command tree v0 is the default. Run `yc desktops <command>` or `yc desktops v0 <command>`.

#### Command Usage

Syntax:

`yc desktops <group>`

#### Command Tree

- [yc desktops desktop](desktop/index.md) — Manage desktop instances

  - [yc desktops desktop create](desktop/create.md) — Create a desktop

  - [yc desktops desktop delete](desktop/delete.md) — Delete the specified desktop

  - [yc desktops desktop get](desktop/get.md) — Get information about a desktop

  - [yc desktops desktop get-rdp-file](desktop/get-rdp-file.md) — Download desktop RDP file

  - [yc desktops desktop list](desktop/list.md) — List desktops

  - [yc desktops desktop list-operations](desktop/list-operations.md) — List operations for the specified desktop

  - [yc desktops desktop reset-password](desktop/reset-password.md) — Reset desktop Password

  - [yc desktops desktop restart](desktop/restart.md) — Restart the specified desktop

  - [yc desktops desktop start](desktop/start.md) — Start the specified desktop

  - [yc desktops desktop stop](desktop/stop.md) — Stop the specified desktop

  - [yc desktops desktop update](desktop/update.md) — Update the specified desktop

  - [yc desktops desktop update-properties](desktop/update-properties.md) — Update a desktop

- [yc desktops group](group/index.md) — Manage desktop groups

  - [yc desktops group add-access-bindings](group/add-access-bindings.md) — Add access binding for the specified desktop group

  - [yc desktops group create](group/create.md) — Create a desktop group

  - [yc desktops group delete](group/delete.md) — Delete the specified desktop group

  - [yc desktops group get](group/get.md) — Get information about a desktop group

  - [yc desktops group list](group/list.md) — List desktops

  - [yc desktops group list-access-bindings](group/list-access-bindings.md) — List access bindings for the specified desktop group

  - [yc desktops group list-desktops](group/list-desktops.md) — List desktops of the specified desktop group

  - [yc desktops group list-operations](group/list-operations.md) — List operations for the specified desktop group

  - [yc desktops group remove-access-bindings](group/remove-access-bindings.md) — Remove access binding for the specified desktop group

  - [yc desktops group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified desktop group and delete all existing access bindings if there were any

  - [yc desktops group update](group/update.md) — Update desktop group

- [yc desktops image](image/index.md) — Manage desktop images

  - [yc desktops image copy](image/copy.md) — Create desktop image as copy of the specified desktop or compute image

  - [yc desktops image delete](image/delete.md) — Delete the specified desktop image

  - [yc desktops image get](image/get.md) — Get information about a desktop image

  - [yc desktops image list](image/list.md) — List desktop images

  - [yc desktops image update](image/update.md) — Update the specified desktop image

- [yc desktops v0](v0/index.md) — Manage Desktop resources



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