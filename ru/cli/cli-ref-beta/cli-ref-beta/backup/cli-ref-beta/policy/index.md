---
editable: false
noIndex: true
---

# yc beta backup policy

A set of methods for managing [policies](/docs/backup/concepts/policy).

#### Command Usage

Syntax:

`yc beta backup policy <command>`

#### Command Tree

- [yc beta backup policy apply](apply.md) — Apply policy to [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

- [yc beta backup policy create](create.md) — Create a new policy.

- [yc beta backup policy delete](delete.md) — Delete specific policy.

- [yc beta backup policy execute](execute.md) — Run policy on specific Compute Cloud instance. That will create backup

- [yc beta backup policy get](get.md) — Get specific policy.

- [yc beta backup policy list](list.md) — List [policies](/docs/backup/concepts/policy) of specified folder.

- [yc beta backup policy list-applications](list-applications.md) — List applied policies using filters.

- [yc beta backup policy revoke](revoke.md) — Revoke policy from Compute Cloud instance.

- [yc beta backup policy update](update.md) — Update specific policy.

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