---
editable: false
noIndex: true
---

# yc beta serverless mdbproxy

A set of methods for managing serverless MDB proxy.

#### Command Usage

Syntax:

`yc beta serverless mdbproxy <command>`

#### Command Tree

- [yc beta serverless mdbproxy create](create.md) — Creates a proxy in the specified folder.

- [yc beta serverless mdbproxy delete](delete.md) — Deletes the specified proxy.

- [yc beta serverless mdbproxy get](get.md) — Returns the specified proxy.

- [yc beta serverless mdbproxy list](list.md) — Retrieves the list of proxies in the specified folder.

- [yc beta serverless mdbproxy list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified proxy.

- [yc beta serverless mdbproxy list-operations](list-operations.md) — Lists operations for the specified proxy.

- [yc beta serverless mdbproxy set-access-bindings](set-access-bindings.md) — Sets access bindings for the proxy.

- [yc beta serverless mdbproxy update](update.md) — Updates the specified proxy.

- [yc beta serverless mdbproxy update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified proxy.

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