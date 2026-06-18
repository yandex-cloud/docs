---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/baremetal/cli-ref/v1alpha/server/
---

# yc baremetal v1alpha server

A set of methods for managing Server resources.

#### Command Usage

Syntax:

`yc baremetal v1alpha server <command>`

#### Command Tree

- [yc baremetal v1alpha server batch-create](batch-create.md) — Creates multiple servers in the specified folder.

- [yc baremetal v1alpha server create](create.md) — Creates a server in the specified folder.

- [yc baremetal v1alpha server get](get.md) — Returns the specific Server resource.

- [yc baremetal v1alpha server list](list.md) — Retrieves the list of Server resources in the specified folder.

- [yc baremetal v1alpha server list-operations](list-operations.md) — Lists operations for the specified server.

- [yc baremetal v1alpha server power-off](power-off.md) — Powers off the specified server.

- [yc baremetal v1alpha server power-on](power-on.md) — Powers on the specified server.

- [yc baremetal v1alpha server reboot](reboot.md) — Reboots the specified server.

- [yc baremetal v1alpha server reinstall](reinstall.md) — Reinstalls the specified server.

- [yc baremetal v1alpha server start-prolongation](start-prolongation.md) — Starts prolongation of the specified server.

- [yc baremetal v1alpha server stop-prolongation](stop-prolongation.md) — Stops prolongation of the specified server.

- [yc baremetal v1alpha server update](update.md) — Updates the specified server.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
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