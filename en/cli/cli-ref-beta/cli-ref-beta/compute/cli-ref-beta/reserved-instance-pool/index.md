---
editable: false
noIndex: true
---

# yc beta compute reserved-instance-pool

A set of methods for managing reserved instance pool resources.

#### Command Usage

Syntax:

`yc beta compute reserved-instance-pool <command>`

#### Command Tree

- [yc beta compute reserved-instance-pool create](create.md) — Creates an reserved instance pool in the specified folder.

- [yc beta compute reserved-instance-pool delete](delete.md) — Deletes the specified reserved instance pool.

- [yc beta compute reserved-instance-pool get](get.md) — Returns the specified reserved instance pool resource.

- [yc beta compute reserved-instance-pool list](list.md) — Retrieves the list of reserved instance pool resources in the specified folder.

- [yc beta compute reserved-instance-pool list-instances](list-instances.md) — Retrieves the list of instances, using the specified reserved instance pool.

- [yc beta compute reserved-instance-pool list-operations](list-operations.md) — Lists operations for the specified reserved instance pool.

- [yc beta compute reserved-instance-pool update](update.md) — Updates the specified reserved instance pool.

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