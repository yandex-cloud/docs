---
editable: false
noIndex: true
---

# yc beta organization-manager idp application oauth



#### Command Usage

Syntax:

`yc beta organization-manager idp application oauth <group>`

#### Command Tree

- [yc beta organization-manager idp application oauth application](application/index.md) — A set of methods for managing OAuth application.

  - [yc beta organization-manager idp application oauth application create](application/create.md) — Creates an OAuth application in the specified organization.

  - [yc beta organization-manager idp application oauth application delete](application/delete.md) — Deletes the specified OAuth application.

  - [yc beta organization-manager idp application oauth application get](application/get.md) — Returns the specified OAuth application resource.

  - [yc beta organization-manager idp application oauth application list](application/list.md) — Retrieves the list of OAuth applications in the specified organization.

  - [yc beta organization-manager idp application oauth application list-access-bindings](application/list-access-bindings.md) — Lists access bindings for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application list-assignments](application/list-assignments.md) — Lists assignmnents for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application list-operations](application/list-operations.md) — Lists operations for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application reactivate](application/reactivate.md) — Sets status to ACTIVE for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application set-access-bindings](application/set-access-bindings.md) — Sets access bindings for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application suspend](application/suspend.md) — Sets status to SUSPENDED for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application update](application/update.md) — Updates the specified OAuth application.

  - [yc beta organization-manager idp application oauth application update-access-bindings](application/update-access-bindings.md) — Updates access bindings for the specified OAuth application.

  - [yc beta organization-manager idp application oauth application update-assignments](application/update-assignments.md) — Updates assignmnents for the specified OAuth application.

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