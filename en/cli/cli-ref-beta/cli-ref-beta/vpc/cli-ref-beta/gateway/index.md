---
editable: false
noIndex: true
---

# yc beta vpc gateway



#### Command Usage

Syntax:

`yc beta vpc gateway <command>`

#### Command Tree

- [yc beta vpc gateway create](create.md) — Creates a gateway in the specified folder.

- [yc beta vpc gateway delete](delete.md) — Deletes the specified gateway.

- [yc beta vpc gateway get](get.md) — Returns the specified Gateway resource.

- [yc beta vpc gateway list](list.md) — Retrieves the list of Gateway resources in the specified folder.

- [yc beta vpc gateway list-operations](list-operations.md) — List operations for the specified gateway.

- [yc beta vpc gateway move](move.md) — Move a gateway to another folder

- [yc beta vpc gateway update](update.md) — Updates the specified gateway.

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