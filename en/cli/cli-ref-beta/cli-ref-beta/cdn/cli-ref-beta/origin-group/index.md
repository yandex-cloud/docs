---
editable: false
noIndex: true
---

# yc beta cdn origin-group

Origin Groups management service.

#### Command Usage

Syntax:

`yc beta cdn origin-group <command>`

#### Command Tree

- [yc beta cdn origin-group create](create.md) — Creates origin group.

- [yc beta cdn origin-group delete](delete.md) — Deletes origin group with specified origin group id.

- [yc beta cdn origin-group get](get.md) — Gets origin group with specified origin group id.

- [yc beta cdn origin-group list](list.md) — Lists origins of origin group.

- [yc beta cdn origin-group update](update.md) — Updates the specified origin group.

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