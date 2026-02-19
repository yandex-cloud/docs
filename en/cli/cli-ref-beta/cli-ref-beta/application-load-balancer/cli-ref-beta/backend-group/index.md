---
editable: false
noIndex: true
---

# yc beta application-load-balancer backend-group

A set of methods for managing backend groups.

#### Command Usage

Syntax:

`yc beta application-load-balancer backend-group <command>`

#### Command Tree

- [yc beta application-load-balancer backend-group add-backend](add-backend.md) — Adds backends to the specified backend group.

- [yc beta application-load-balancer backend-group create](create.md) — Creates a backend group in the specified folder.

- [yc beta application-load-balancer backend-group delete](delete.md) — Deletes the specified backend group.

- [yc beta application-load-balancer backend-group get](get.md) — Returns the specified backend group.

- [yc beta application-load-balancer backend-group list](list.md) — Lists backend groups in the specified folder.

- [yc beta application-load-balancer backend-group list-operations](list-operations.md) — Lists operations for the specified backend group.

- [yc beta application-load-balancer backend-group remove-backend](remove-backend.md) — Removes backends from the specified backend group.

- [yc beta application-load-balancer backend-group update](update.md) — Updates the specified backend group.

- [yc beta application-load-balancer backend-group update-backend](update-backend.md) — Updates the specified backend.

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