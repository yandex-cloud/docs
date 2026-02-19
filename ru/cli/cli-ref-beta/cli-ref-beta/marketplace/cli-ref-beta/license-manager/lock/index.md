---
editable: false
noIndex: true
---

# yc beta marketplace license-manager lock

A set of methods for managing subscription locks.

#### Command Usage

Syntax:

`yc beta marketplace license-manager lock <command>`

#### Command Tree

- [yc beta marketplace license-manager lock create](create.md) — Locks the specified subscription instance to the resource.

- [yc beta marketplace license-manager lock delete](delete.md) — Unlocks the specified subscription lock.

- [yc beta marketplace license-manager lock ensure](ensure.md) — Checks if the she specified subscription is already locked to the specified resource.

- [yc beta marketplace license-manager lock get](get.md) — Returns the specified subscription lock.

- [yc beta marketplace license-manager lock get-by-instance-and-resource](get-by-instance-and-resource.md) — Returns the subscription lock for specified subscription instance and resource.

- [yc beta marketplace license-manager lock list](list.md) — Returns subscriptions locks for specified resource and folder.

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