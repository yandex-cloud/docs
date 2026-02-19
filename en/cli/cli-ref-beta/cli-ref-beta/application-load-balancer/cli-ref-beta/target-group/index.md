---
editable: false
noIndex: true
---

# yc beta application-load-balancer target-group

A set of methods for managing target groups.

#### Command Usage

Syntax:

`yc beta application-load-balancer target-group <command>`

#### Command Tree

- [yc beta application-load-balancer target-group add-targets](add-targets.md) — Adds targets to the specified target group.

- [yc beta application-load-balancer target-group create](create.md) — Creates a target group in the specified folder.

- [yc beta application-load-balancer target-group delete](delete.md) — Deletes the specified target group.

- [yc beta application-load-balancer target-group get](get.md) — Returns the specified target group.

- [yc beta application-load-balancer target-group list](list.md) — Lists target groups in the specified folder.

- [yc beta application-load-balancer target-group list-operations](list-operations.md) — Lists operations for the specified target group.

- [yc beta application-load-balancer target-group remove-targets](remove-targets.md) — Removes targets from the specified target group.

- [yc beta application-load-balancer target-group update](update.md) — Updates the specified target group.

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