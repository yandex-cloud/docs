---
editable: false
noIndex: true
---

# yc beta application-load-balancer virtual-host

A set of methods for managing virtual hosts of HTTP routers.

#### Command Usage

Syntax:

`yc beta application-load-balancer virtual-host <command>`

#### Command Tree

- [yc beta application-load-balancer virtual-host create](create.md) — Creates a virtual host in the specified HTTP router.

- [yc beta application-load-balancer virtual-host delete](delete.md) — Deletes the specified virtual host.

- [yc beta application-load-balancer virtual-host get](get.md) — Returns the specified virtual host.

- [yc beta application-load-balancer virtual-host list](list.md) — Lists virtual hosts of the specified HTTP router.

- [yc beta application-load-balancer virtual-host remove-route](remove-route.md) — Deletes the specified route from the specified virtual host.

- [yc beta application-load-balancer virtual-host update](update.md) — Updates the specified virtual host of the specified HTTP router.

- [yc beta application-load-balancer virtual-host update-route](update-route.md) — Updates the specified route of the specified virtual host.

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