---
editable: false
noIndex: true
---

# yc beta managed-redis user

A set of methods for managing Redis User resources.

#### Command Usage

Syntax:

`yc beta managed-redis user <command>`

#### Command Tree

- [yc beta managed-redis user create](create.md) — Creates a Redis user in the specified cluster.

- [yc beta managed-redis user delete](delete.md) — Deletes the specified Redis user.

- [yc beta managed-redis user get](get.md) — Returns the specified Redis User resource.

- [yc beta managed-redis user list](list.md) — Retrieves the list of Redis User resources in the specified cluster.

- [yc beta managed-redis user update](update.md) — Updates the specified Redis user.

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