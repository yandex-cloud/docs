---
editable: false
noIndex: true
---

# yc beta application-load-balancer http-router

A set of methods for managing HTTP routers.

#### Command Usage

Syntax:

`yc beta application-load-balancer http-router <command>`

#### Command Tree

- [yc beta application-load-balancer http-router create](create.md) — Creates an HTTP router in the specified folder.

- [yc beta application-load-balancer http-router delete](delete.md) — Deletes the specified HTTP router.

- [yc beta application-load-balancer http-router get](get.md) — Returns the specified HTTP router.

- [yc beta application-load-balancer http-router list](list.md) — Lists HTTP routers in the specified folder.

- [yc beta application-load-balancer http-router list-operations](list-operations.md) — Lists operations for the specified HTTP router.

- [yc beta application-load-balancer http-router update](update.md) — Updates the specified HTTP router.

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