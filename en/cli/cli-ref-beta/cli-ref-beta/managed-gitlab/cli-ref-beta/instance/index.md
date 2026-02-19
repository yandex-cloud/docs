---
editable: false
noIndex: true
---

# yc beta managed-gitlab instance

InstanceService provides methods for managing GitLab instances.

#### Command Usage

Syntax:

`yc beta managed-gitlab instance <command>`

#### Command Tree

- [yc beta managed-gitlab instance create](create.md) — Creates a new GitLab instance in the specified folder.

- [yc beta managed-gitlab instance delete](delete.md) — Deletes the specified GitLab instance.

- [yc beta managed-gitlab instance get](get.md) — Returns the specified GitLab instance.

- [yc beta managed-gitlab instance list](list.md) — Retrieves the list of GitLab instances in the specified folder.

- [yc beta managed-gitlab instance start](start.md) — Starts the specified GitLab instance.

- [yc beta managed-gitlab instance stop](stop.md) — Stops the specified GitLab instance.

- [yc beta managed-gitlab instance update](update.md) — Updates GitLab instance.

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