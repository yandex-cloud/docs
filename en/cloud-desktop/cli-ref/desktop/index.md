---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/desktops/cli-ref/desktop/
---

# yc desktops desktop

Manage desktop instances

#### Command Usage

Syntax:

`yc desktops desktop <command>`

#### Command Tree

- [yc desktops desktop create](create.md) — Create a desktop

- [yc desktops desktop delete](delete.md) — Delete the specified desktop

- [yc desktops desktop get](get.md) — Get information about a desktop

- [yc desktops desktop get-rdp-file](get-rdp-file.md) — Download desktop RDP file

- [yc desktops desktop list](list.md) — List desktops

- [yc desktops desktop list-operations](list-operations.md) — List operations for the specified desktop

- [yc desktops desktop reset-password](reset-password.md) — Reset desktop Password

- [yc desktops desktop restart](restart.md) — Restart the specified desktop

- [yc desktops desktop start](start.md) — Start the specified desktop

- [yc desktops desktop stop](stop.md) — Stop the specified desktop

- [yc desktops desktop update](update.md) — Update the specified desktop

- [yc desktops desktop update-properties](update-properties.md) — Update a desktop

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