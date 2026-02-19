---
editable: false
noIndex: true
---

# yc beta vpc network

A set of methods for managing Network resources.

#### Command Usage

Syntax:

`yc beta vpc network <command>`

#### Command Tree

- [yc beta vpc network create](create.md) — Creates a network in the specified folder using the data specified in the request.

- [yc beta vpc network delete](delete.md) — Deletes the specified network.

- [yc beta vpc network get](get.md) — Returns the specified Network resource.

- [yc beta vpc network list](list.md) — Retrieves the list of Network resources in the specified folder.

- [yc beta vpc network list-operations](list-operations.md) — Lists operations for the specified network.

- [yc beta vpc network list-route-tables](list-route-tables.md) — Lists route tables from the specified network.

- [yc beta vpc network list-security-groups](list-security-groups.md) — Lists security groups from the specified network.

- [yc beta vpc network list-subnets](list-subnets.md) — Lists subnets from the specified network.

- [yc beta vpc network move](move.md) — Move network to another folder.

- [yc beta vpc network update](update.md) — Updates the specified network.

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