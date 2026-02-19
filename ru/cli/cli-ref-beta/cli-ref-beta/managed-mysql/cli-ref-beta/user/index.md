---
editable: false
noIndex: true
---

# yc beta managed-mysql user

A set of methods for managing MySQL users.
See [the documentation](/docs/managed-mysql/operations/cluster-users) for details.

#### Command Usage

Syntax:

`yc beta managed-mysql user <command>`

#### Command Tree

- [yc beta managed-mysql user create](create.md) — Creates a user in a cluster.

- [yc beta managed-mysql user delete](delete.md) — Deletes a user in a cluster.

- [yc beta managed-mysql user get](get.md) — Retrieves information about the specified user.

- [yc beta managed-mysql user grant-permission](grant-permission.md) — Grants permission to access a database to a user in a cluster.

- [yc beta managed-mysql user list](list.md) — Retrieves the list of users in a cluster.

- [yc beta managed-mysql user revoke-permission](revoke-permission.md) — Revokes permission to access a database from a user in a cluster.

- [yc beta managed-mysql user update](update.md) — Updates a user in a cluster.

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