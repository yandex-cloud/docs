---
editable: false
noIndex: true
---

# yc beta container registry

A set of methods for managing Registry resources.

#### Command Usage

Syntax:

`yc beta container registry <command>`

#### Command Tree

- [yc beta container registry create](create.md) — Creates a registry in the specified folder.

- [yc beta container registry delete](delete.md) — Deletes the specified registry.

- [yc beta container registry get](get.md) — Returns the specified Registry resource.

- [yc beta container registry list](list.md) — Retrieves the list of Registry resources in the specified folder.

- [yc beta container registry list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified registry.

- [yc beta container registry list-ip-permission](list-ip-permission.md) — List ip permissions for the specified registry.

- [yc beta container registry set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified registry.

- [yc beta container registry set-ip-permission](set-ip-permission.md) — Set ip permissions for the specified registry.

- [yc beta container registry update](update.md) — Updates the specified registry.

- [yc beta container registry update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified registry.

- [yc beta container registry update-ip-permission](update-ip-permission.md) — Update ip permissions for the specified registry.

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
|| `-h`, `--help` | Display help for the command. ||
|#