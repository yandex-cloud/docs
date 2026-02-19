---
editable: false
noIndex: true
---

# yc beta organization-manager group

A set of methods for managing groups.

#### Command Usage

Syntax:

`yc beta organization-manager group <command>`

#### Command Tree

- [yc beta organization-manager group convert-all-to-basic](convert-all-to-basic.md) — Converts all groups that belongs to subject container from external to basic (not external).

- [yc beta organization-manager group convert-to-external](convert-to-external.md) — Converts single basic (not external) group to external. Precondition: group must be basic.

- [yc beta organization-manager group create](create.md) — Creates a group in the specified organization.

- [yc beta organization-manager group create-external](create-external.md) — Creates an external group.

- [yc beta organization-manager group delete](delete.md) — Deletes the specified group.

- [yc beta organization-manager group get](get.md) — Returns the specified Group resource.

- [yc beta organization-manager group list](list.md) — Retrieves the list of group resources.

- [yc beta organization-manager group list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified group.

- [yc beta organization-manager group list-effective](list-effective.md) — Returns groups that the subject belongs to within a specific organization.

- [yc beta organization-manager group list-external](list-external.md) — Retrieves the list of external group linked subject container

- [yc beta organization-manager group list-members](list-members.md) — List group active members.

- [yc beta organization-manager group list-operations](list-operations.md) — Lists operations for the specified group.

- [yc beta organization-manager group resolve-external](resolve-external.md) — Returns external group by subject container and external id

- [yc beta organization-manager group set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified group.

- [yc beta organization-manager group update](update.md) — Updates the specified group.

- [yc beta organization-manager group update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified group.

- [yc beta organization-manager group update-members](update-members.md) — Update group members.

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