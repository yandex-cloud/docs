---
editable: false
noIndex: true
---

# yc beta marketplace license-manager



#### Command Usage

Syntax:

`yc beta marketplace license-manager <group>`

#### Command Tree

- [yc beta marketplace license-manager instance](instance/index.md) — A set of methods for managing subscription instances.

  - [yc beta marketplace license-manager instance get](instance/get.md) — Returns the specified subscription instance.

  - [yc beta marketplace license-manager instance list](instance/list.md) — Retrieves the list of subscription instances in the specified folder.

- [yc beta marketplace license-manager lock](lock/index.md) — A set of methods for managing subscription locks.

  - [yc beta marketplace license-manager lock create](lock/create.md) — Locks the specified subscription instance to the resource.

  - [yc beta marketplace license-manager lock delete](lock/delete.md) — Unlocks the specified subscription lock.

  - [yc beta marketplace license-manager lock ensure](lock/ensure.md) — Checks if the she specified subscription is already locked to the specified resource.

  - [yc beta marketplace license-manager lock get](lock/get.md) — Returns the specified subscription lock.

  - [yc beta marketplace license-manager lock get-by-instance-and-resource](lock/get-by-instance-and-resource.md) — Returns the subscription lock for specified subscription instance and resource.

  - [yc beta marketplace license-manager lock list](lock/list.md) — Returns subscriptions locks for specified resource and folder.

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