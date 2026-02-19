---
editable: false
noIndex: true
---

# yc beta cdn resource-rules

Rules management service.
Used for Resources Rules management.

#### Command Usage

Syntax:

`yc beta cdn resource-rules <command>`

#### Command Tree

- [yc beta cdn resource-rules create](create.md) — Create new resource rule with specified unique name and rule patter.

- [yc beta cdn resource-rules delete](delete.md) — Delete specified by id resource rule.

- [yc beta cdn resource-rules get](get.md) — Get specified by id resource rule.

- [yc beta cdn resource-rules list](list.md) — List all rules for specified resource.

- [yc beta cdn resource-rules update](update.md) — Update specified by id resource rule.

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