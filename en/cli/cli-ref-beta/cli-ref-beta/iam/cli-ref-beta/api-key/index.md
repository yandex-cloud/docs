---
editable: false
noIndex: true
---

# yc beta iam api-key

A set of methods for managing API keys.

#### Command Usage

Syntax:

`yc beta iam api-key <command>`

#### Command Tree

- [yc beta iam api-key create](create.md) — Creates an API key for the specified service account.

- [yc beta iam api-key delete](delete.md) — Deletes the specified API key.

- [yc beta iam api-key get](get.md) — Returns the specified API key.

- [yc beta iam api-key list](list.md) — Retrieves the list of API keys for the specified service account.

- [yc beta iam api-key list-operations](list-operations.md) — Retrieves the list of operations for the specified API key.

- [yc beta iam api-key list-scopes](list-scopes.md) — Retrieves the list of scopes.

- [yc beta iam api-key update](update.md) — Updates the specified API key.

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