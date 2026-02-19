---
editable: false
noIndex: true
---

# yc beta vpc security-group

A set of methods for managing SecurityGroup resources.

#### Command Usage

Syntax:

`yc beta vpc security-group <command>`

#### Command Tree

- [yc beta vpc security-group create](create.md) — Creates a security group in the specified folder and network.

- [yc beta vpc security-group delete](delete.md) — Deletes the specified security group.

- [yc beta vpc security-group get](get.md) — Returns the specified SecurityGroup resource.

- [yc beta vpc security-group list](list.md) — Retrieves the list of SecurityGroup resources in the specified folder.

- [yc beta vpc security-group list-operations](list-operations.md) — Lists operations for the specified security groups.

- [yc beta vpc security-group move](move.md) — Moves security groups to another folder.

- [yc beta vpc security-group update](update.md) — Updates the specified security group.

- [yc beta vpc security-group update-rule](update-rule.md) — Updates the specified rule.

- [yc beta vpc security-group update-rules](update-rules.md) — Updates the rules of the specified security group.

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