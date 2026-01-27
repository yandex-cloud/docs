---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/repository/index.md
---

# yc beta container repository

A set of methods for managing Repository resources.

#### Command Usage

Syntax:

`yc beta container repository <command>`

#### Command Tree

- [yc beta container repository delete](delete.md) — Deletes the specified repository.

- [yc beta container repository get](get.md) — Returns the specified Repository resource.

- [yc beta container repository get-by-name](get-by-name.md) — Returns the specified Repository resource.

- [yc beta container repository list](list.md) — Retrieves the list of Repository resources in the specified registry.

- [yc beta container repository list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified repository.

- [yc beta container repository set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified repository.

- [yc beta container repository update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified repository.

- [yc beta container repository upsert](upsert.md) — Upserts a repository in the specified registry.

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