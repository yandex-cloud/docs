---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/federation/group-mapping/index.md
---

# yc beta organization-manager federation group-mapping

RPC service dedicated for federation group mapping.

#### Command Usage

Syntax:

`yc beta organization-manager federation group-mapping <command>`

#### Command Tree

- [yc beta organization-manager federation group-mapping create](create.md) — Adds a group mapping for a federation

- [yc beta organization-manager federation group-mapping delete](delete.md) — Deletes a group mapping. This will remove all the mapping items

- [yc beta organization-manager federation group-mapping get](get.md) — Returns a group mapping configured for the specific federation

- [yc beta organization-manager federation group-mapping list-items](list-items.md) — Returns all the group mappings items

- [yc beta organization-manager federation group-mapping update](update.md) — Updates an existing group mapping for a federation

- [yc beta organization-manager federation group-mapping update-items](update-items.md) — Updates group mapping items for a specified federation

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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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